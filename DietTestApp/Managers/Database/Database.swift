//
//  Database.swift
//  DietTestApp
//
//  Created by Maksym Horbenko on 07.07.2021.
//

import Foundation
import RealmSwift

final class Database: NSObject {
    
    static let shared = Database()
    private override init() { }
    
    let dataBaseQueue = RealmDatabaseQueue()
    
    lazy var dataBaseThread = RealmDatabaseThread().apply {
        $0.workingQueue = { [unowned self] key in
            self.dataBaseQueue.get(by: key)
        }
    }
    
    var realm: Realm {
        return try! dataBaseThread.getInstance()
    }
    
    private let schemaVersion: UInt64 = {
        let version: UInt64 = UInt64(Bundle.main.object(forInfoDictionaryKey: "DatabaseSchemeVersion") as! Int)
        return version
    }()

    func setup() {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: schemaVersion, migrationBlock:  { [weak self] migration, oldSchemaVersion in
            guard let `self` = self else {return}
            // We haven’t migrated anything yet, so oldSchemaVersion == 0
            if (oldSchemaVersion < self.schemaVersion) {
                // Nothing to do!
                // Realm will automatically detect new properties and removed properties
                // And will update the schema on disk automatically
            }
        })
    }
    
    
    func createStartingData() throws {
        let post1 = DBFeedPost()
        post1.id = UUID().uuidString
        post1.createdAt = Int(Date().timeIntervalSince1970)
        post1.imageName = "image_food_asset_1"
        
        let postComment1 = DBPostComment()
        postComment1.id = UUID().uuidString
        postComment1.userName = "Username"
        postComment1.text = "Test comment text, test comment text"
        postComment1.imageName = "image_user_avatar_placeholder"
        
        post1.comments.removeAll()
        post1.comments.append(postComment1)
        
        let post2 = DBFeedPost()
        post2.id = UUID().uuidString
        post2.createdAt = Int(Date().timeIntervalSince1970)
        post2.imageName = "image_food_asset_2"

        let postComment2 = DBPostComment()
        postComment2.id = UUID().uuidString
        postComment2.userName = "Username2"
        postComment2.text = "Test comment 2 text, test comment 2 text"
        postComment2.imageName = "image_user_avatar_placeholder"
        
        post2.comments.removeAll()
        post2.comments.append(postComment2)

        try realm.write {
            realm.add(post1)
            realm.add(post2)
        }
    }
    
}

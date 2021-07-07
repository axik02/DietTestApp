//
//  RealmDatabaseThread.swift
//  DietTestApp
//
//  Created by Maksym Horbenko on 07.07.2021.
//

import Foundation
import RealmSwift

extension Realm: Applyable {}

extension RealmDatabaseThread: Applyable {}

struct DispatchQueueLabes {
    static let mainLabel = DispatchQueue.main.label
    static let backgroundLabel = "io.realm.Database.backgroundQueue"
}

final class RealmDatabaseThread {
    
    typealias Key = String
    typealias WorkingQueue = (_ key: Key) -> DispatchQueue?
    
    // MARK: - Properties
    // MARK: Content
    
    private lazy var realms = [Key : Realm]()
    
    // MARK: Inputs
    
    var workingQueue: WorkingQueue?
    
    // MARK: - Appearance
    
    func getInstance() throws -> Realm {
        let key = try threadKey()
        return try realm(by: key).apply { realm in
            realm.refresh()
        }
    }
    
    private func realm(by key: Key) throws -> Realm {
        if realms.keys.contains(key) {
            let realm = realms[key]
            if realm?.isFrozen == true {
                realms.removeValue(forKey: key)
                return try self.realm(by: key)
            }
            return realm!
        }
        let realm = try Realm(queue: workingQueue?(key))
        realms[key] = realm
        return realm
    }
    
    private func threadKey() throws -> Key {
        let key = __dispatch_queue_get_label(nil)
        guard let representableKey = Key(cString: key, encoding: .utf8) else {
            throw ErrorHelper.shared.error("Thread key error")
        }
        return representableKey
    }
    
}

final class RealmDatabaseQueue {
    
    // MARK: - Properties
    
    private(set) lazy var background = DispatchQueue(
        label: DispatchQueueLabes.backgroundLabel,
        qos: .userInitiated
    )
    
    private lazy var queues: [String : DispatchQueue] = [
        DispatchQueue.main.label : .main,
        background.label : background
    ]
    
    // MARK: - Appearance
    
    func get(by name: String) -> DispatchQueue? {
        queues[name]
    }
}

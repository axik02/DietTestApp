//
//  DBFeedPost.swift
//  DietTestApp
//
//  Created by Maksym Horbenko on 07.07.2021.
//

import Foundation
import RealmSwift

class DBFeedPost: Object {
    @objc dynamic var id: String = ""
    
    @objc dynamic var imageName: String = ""
    
    @objc dynamic var likesCount: Int = 0
    @objc dynamic var savesCount: Int = 0
    
    @objc dynamic var isSaved: Bool = false
    @objc dynamic var isLiked: Bool = false
    
    @objc dynamic var createdAt: Int = 0

    let comments = List<DBPostComment>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

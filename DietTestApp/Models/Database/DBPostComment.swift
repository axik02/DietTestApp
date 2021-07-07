//
//  DBPostComment.swift
//  DietTestApp
//
//  Created by Maksym Horbenko on 07.07.2021.
//

import Foundation
import RealmSwift

class DBPostComment: Object {
    
    @objc dynamic var id: String = ""
    @objc dynamic var imageName: String = ""
    @objc dynamic var userName: String = ""
    @objc dynamic var text: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

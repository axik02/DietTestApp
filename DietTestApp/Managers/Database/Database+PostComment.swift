//
//  Database+PostComment.swift
//  DietTestApp
//
//  Created by Maksym Horbenko on 07.07.2021.
//

import Foundation
import RealmSwift

extension Database {
    
    func createComment(for postID: String, text: String) throws {
        guard let post = realm.object(ofType: DBFeedPost.self, forPrimaryKey: postID) else { return }

        let comment = DBPostComment()
        comment.id = UUID().uuidString
        comment.userName = "newuser"
        comment.text = text
        comment.imageName = "image_user_avatar_placeholder"
        

        try realm.write {
            post.comments.append(comment)

            realm.add(post, update: .all)
        }
    }
    
}

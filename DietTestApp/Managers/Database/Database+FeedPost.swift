//
//  Database+FeedPost.swift
//  DietTestApp
//
//  Created by Maksym Horbenko on 07.07.2021.
//

import Foundation
import RealmSwift

extension Database {
    
    func getFeedPosts(sortedAscending: Bool? = true) -> Results<DBFeedPost> {
        let posts: Results<DBFeedPost>
        if let ascending = sortedAscending {
            posts = realm
                .objects(DBFeedPost.self)
                .sorted(byKeyPath: "createdAt", ascending: ascending)
        } else {
            posts = realm
                .objects(DBFeedPost.self)
        }
        
        return posts
    }
    
    func getPost(id: String) -> DBFeedPost? {
        realm.object(ofType: DBFeedPost.self, forPrimaryKey: id)
    }
    
    func changePostLike(id: String, value: Bool) throws {
        guard let post = realm.object(ofType: DBFeedPost.self, forPrimaryKey: id) else { return }

        try realm.write {
            post.isLiked = value
            if value {
                post.likesCount += 1
            } else {
                post.likesCount = max(0, post.likesCount - 1)
            }
            realm.add(post, update: .all)
        }
    }
    
}

//
//  FeedPost.swift
//  DietTestApp
//
//  Created by Maksym Horbenko on 07.07.2021.
//

import Foundation

struct FeedPost: Equatable {
    
    let id: String
    
    let imageName: String
    
    let likesCount: Int
    let savesCount: Int
    
    let isSaved: Bool
    let isLiked: Bool
    
    let createdAt: Int
    
    let comments: [PostComment]
    
    static func == (lhs: FeedPost, rhs: FeedPost) -> Bool {
        return lhs.id == rhs.id &&
            lhs.imageName == rhs.imageName &&
            lhs.likesCount == rhs.likesCount &&
            lhs.savesCount == rhs.savesCount &&
            lhs.isSaved == rhs.isSaved &&
            lhs.isLiked == rhs.isLiked &&
            lhs.createdAt == rhs.createdAt &&
            lhs.comments == rhs.comments
    }

}

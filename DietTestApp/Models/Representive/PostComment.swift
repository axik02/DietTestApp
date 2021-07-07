//
//  PostComment.swift
//  DietTestApp
//
//  Created by Maksym Horbenko on 07.07.2021.
//

import Foundation

struct PostComment: Equatable {
    let id: String
    let imageName: String
    let userName: String
    let text: String
    
    static func == (lhs: PostComment, rhs: PostComment) -> Bool {
        return lhs.id == rhs.id &&
            lhs.imageName == rhs.imageName &&
            lhs.userName == rhs.userName &&
            lhs.text == rhs.text
    }
}

extension PostComment {
    static func convert(from dbo: DBPostComment) -> PostComment {
        PostComment(id: dbo.id, imageName: dbo.imageName, userName: dbo.userName, text: dbo.text)
    }
}

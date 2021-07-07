//
//  FeedSectionData.swift
//  DietTestApp
//
//  Created by Maksym Horbenko on 07.07.2021.
//

import Foundation
import RxSwift
import RxDataSources

struct FeedSectionData {
    var type: SectionType
    var items: [CellItem]
    
    enum CellItem: IdentifiableType, Equatable {
        case foodPost(post: FeedPost)
        
        typealias Identity = String
        
        var identity : Identity {
            switch self {
            case .foodPost(let post):
                return "food_post_\(post.id)"
            }
        }
        
        static func == (lhs: FeedSectionData.CellItem, rhs: FeedSectionData.CellItem) -> Bool {
            switch (lhs, rhs) {
            case (.foodPost(let lPost), .foodPost(let rPost)):
                return lhs.identity == rhs.identity && lPost == rPost
            }
        }
    }
}

extension FeedSectionData: AnimatableSectionModelType {
    typealias Item = CellItem
    
    typealias Identity = String
    var identity: String {
        return type.identity
    }
    
    enum SectionType {
        case post
        
        var identity: String {
            switch self {
            case .post:
                return "section_post"
            }
        }
    }
    
    init(original: FeedSectionData, items: [CellItem]) {
        self = original
        self.items = items
    }
}

//
//  FeedViewModel.swift
//  DietTestApp
//
//  Created by Maksym Horbenko on 06.07.2021.
//

import Foundation

import RealmSwift
import Realm

import RxSwift
import RxRelay

final class FeedViewModel: ViewModel {
    enum State {
        case loading
    }
    var state: ((State?) -> Void)?
    
    enum Action {

    }
    var actions: ((Action) -> Void)?
    
    var feedPosts: Results<DBFeedPost>
    
    required init() {
        self.feedPosts = Database.shared.getFeedPosts(sortedAscending: false)
        setupRealmObservation()
    }
    
    deinit {
        unsubscribeFromRealm()
    }
    
    var sectionData: BehaviorRelay<[FeedSectionData]> = .init(value: [.init(type: .post, items: [])])
    
    // MARK: - Realm Notifications
    
    private var postsNotificationToken: RLMNotificationToken?
    
    func onLoad() {
        state?(.none)
    }
        
}

// MARK: - On Actions

extension FeedViewModel {
    
    func onSend(text: String, postID: String) {
        try? Database.shared.createComment(for: postID, text: text)
    }
    
    func onLike(postID: String, oldValue: Bool) {
        try? Database.shared.changePostLike(id: postID, value: !oldValue)
    }
    
}

// MARK: - Realm

extension FeedViewModel {
    
    // MARK: - Comments subscribe
    
    private func setupRealmObservation() {
        self.postsNotificationToken = self.feedPosts.observe(on: .main) { [weak self] (change) in
            guard let `self` = self else {return}
            switch change {
            default:
                self.onPostsUpdated()
            }
        }
    }
    
    private func unsubscribeFromRealm() {
        self.postsNotificationToken?.invalidate()
        self.postsNotificationToken = nil
    }
    
    private func onPostsUpdated() {
        var sections = sectionData.value
        
        guard let postSectionIndex = sections.firstIndex(where: { $0.type == .post }) else { return }
        
        let newItems: [FeedSectionData.CellItem] = feedPosts.map {
            FeedSectionData.CellItem.foodPost(
                post: FeedPost(
                    id: $0.id,
                    imageName: $0.imageName,
                    likesCount: $0.likesCount,
                    savesCount: $0.savesCount,
                    isSaved: $0.isSaved,
                    isLiked: $0.isLiked,
                    createdAt: $0.createdAt,
                    comments: $0.comments.map {
                        PostComment.convert(from: $0)
                    }
                )
            )
        }
        
        sections[postSectionIndex] = .init(original: sections[postSectionIndex], items: newItems)
        
        sectionData.accept(sections)
    }

}

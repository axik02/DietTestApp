//
//  FeedViewController.swift
//  DietTestApp
//
//  Created by Maksym Horbenko on 06.07.2021.
//

import UIKit

import RxSwift
import RxCocoa
import RxDataSources

final class FeedViewController: ViewController<FeedContentView> {
    
    private lazy var feedDataSource: RxTableViewSectionedAnimatedDataSource<FeedSectionData> = {
        return RxTableViewSectionedAnimatedDataSource<FeedSectionData>(
            configureCell: { dataSource, tableView, indexPath, item in
                switch item {
                case .foodPost(let post):
                    let cell = tableView.dequeueReusableCell(withClass: FoodTableViewCell.self)
                    let data: FoodTableViewCell.Data = .init(
                        foodImage: UIImage(named: post.imageName),
                        comments: post.comments.map({
                            FoodTableViewCell
                                .Data
                                .CommentData(avatarImage: UIImage(named: $0.imageName),
                                             name: $0.userName,
                                             text: $0.text)
                        }),
                        likeCount: post.likesCount,
                        savesCount: post.savesCount,
                        isLiked: post.isLiked,
                        isSaved: post.isSaved,
                        createdAt: post.createdAt
                    )
                    cell.configure(withData: data)
                    cell.actions = { [weak self] (action) in
                        switch action {
                        case .likeTapped:
                            self?.contentView.viewModel.onLike(
                                postID: post.id,
                                oldValue: post.isLiked
                            )
                        case .sendText(let text):
                            self?.contentView.viewModel.onSend(
                                text: text,
                                postID: post.id
                            )
                        }
                    }
                    return cell
                }
            })
    }()
    
    private var disposeBag = DisposeBag()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func configure() {
        super.configure()
        configureView()
        configureBindings()
    }
    
    override func actions() {
        super.actions()
    }
    
    override func notifies() {
        super.notifies()
        
        contentView.viewModel.state = { [weak self] state in
            guard let self = self else { return }
            
            switch state {
            case .loading:
                self.contentView.displayAnimatedActivityIndicatorView(color: .white, style: .large)
            case .none:
                self.contentView.hideAnimatedActivityIndicatorView()
            }
        }
    }
    
    private func configureView() {
        navigationController?.navigationBar.barStyle = .black
        
        feedDataSource.animationConfiguration = .init(
            insertAnimation: .automatic,
            reloadAnimation: .none,
            deleteAnimation: .fade
        )
    }
    
    private func configureBindings() {
        contentView.viewModel.sectionData
            .bind(to: contentView.feedTableView.rx.items(dataSource: feedDataSource))
            .disposed(by: disposeBag)
    }
}

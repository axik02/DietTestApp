//
//  FoodTableViewCell.swift
//  DietTestApp
//
//  Created by Maksym Horbenko on 06.07.2021.
//

import UIKit
import SwifterSwift

final class FoodTableViewCell: UITableViewCell {
    
    // MARK: - Actions
    
    enum Action {
        case sendText(text: String)
        case likeTapped
    }
    
    var actions: ((Action) -> Void)?
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    // MARK: - Override methods

    override func prepareForReuse() {
        super.prepareForReuse()
        commentsStackView.removeArrangedSubviews()
        commentsStackView.removeSubviews()
        commentInputTextField.delegate = nil
        likeButton.removeTarget(self, action: #selector(likeButtonTapped(_:)), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateSubviewLayers()
    }
        
    // MARK: - UI

    let contentStackView = UIStackView().apply {
        $0.backgroundColor = .clear
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .fill
        $0.spacing = 12
    }
    
    let foodImageView = UIImageView().apply {
        $0.contentMode = .scaleAspectFill
    }
    
    let commentsStackView = UIStackView().apply {
        $0.backgroundColor = .clear
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = 6
    }
    
    let commentInputTextField = UITextField().apply {
        $0.textColor = UIColor(hexString: "#E6E6E6")
        $0.attributedPlaceholder = NSAttributedString(
            string: "Add a comment...",
            attributes: [
                .foregroundColor: UIColor(hexString: "D9D9D9", transparency: 0.5) ?? .gray
            ]
        )
        $0.font = .main(size: 15)
        $0.returnKeyType = .send
    }
    
    let actionButtonStackView = UIStackView().apply {
        $0.axis = .horizontal
        $0.alignment = .leading
        $0.distribution = .fill
        $0.spacing = 16
    }
        
    let likeActionStackView = UIStackView().apply {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = 8
    }
    
    let likeIcon = UIImageView().apply {
        $0.image = UIImage(named: "icon_heart")
        $0.tintColor = UIColor(hexString: "#FEC202")
    }
    
    let likeCountLabel = UILabel().apply {
        $0.textColor = UIColor(hexString: "#FEC202")
        $0.font = .main(weight: .bold, size: 15)
    }
    
    let likeButton = UIButton()
    
    let saveActionStackView = UIStackView().apply {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = 8
    }
    
    let saveIcon = UIImageView().apply {
        $0.image = UIImage(named: "icon_save_active")
        $0.tintColor = UIColor(hexString: "#FEC202")
    }
    
    let saveCountLabel = UILabel().apply {
        $0.textColor = UIColor(hexString: "#FEC202")
        $0.font = .main(weight: .bold, size: 15)
    }
    
    let createdAtLabel = UILabel().apply {
        $0.textColor = UIColor(hexString: "#D9D9D9")
        $0.font = .main(size: 15)
        $0.textAlignment = .left
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        addSubview(contentStackView)
        contentStackView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 14, left: 18, bottom: 14, right: 18))
        }
        
        contentStackView.addArrangedSubviews([foodImageView, commentsStackView, commentInputTextField, actionButtonStackView, createdAtLabel])
        
        let spacerView = UIView()
        
        actionButtonStackView.addArrangedSubviews([likeActionStackView, saveActionStackView, spacerView])
        
        likeActionStackView.addArrangedSubviews([likeIcon, likeCountLabel])
        
        addSubview(likeButton)
        likeButton.snp.makeConstraints { make in
            make.edges.equalTo(likeActionStackView)
        }
        
        saveActionStackView.addArrangedSubviews([saveIcon, saveCountLabel])
        
        foodImageView.snp.makeConstraints { make in
            make.height.equalTo(270)
            make.leading.trailing.equalToSuperview()
        }
        
        commentsStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(9)
            make.trailing.equalToSuperview().inset(9)
        }
        
        commentInputTextField.snp.makeConstraints { make in
            make.height.equalTo(22)
            make.leading.equalToSuperview().offset(60)
            make.trailing.equalToSuperview().inset(60)
        }
        
        actionButtonStackView.snp.makeConstraints { make in
            make.height.equalTo(29)
            make.leading.equalToSuperview().offset(9)
            make.trailing.equalToSuperview().inset(9)
        }
        
        createdAtLabel.snp.makeConstraints { make in
            make.height.equalTo(19)
            make.leading.equalToSuperview().offset(9)
            make.trailing.equalToSuperview().inset(9)
        }
    }
    
    private func updateSubviewLayers() {
        foodImageView.clipsToBounds = true
        foodImageView.layer.cornerRadius = 20
    }
    
    // MARK: - Configuration
    
    struct Data {
        let foodImage: UIImage?
        let comments: [CommentData]
        
        let likeCount: Int
        let savesCount: Int
        
        let isLiked: Bool
        let isSaved: Bool
        
        let createdAt: Int
        
        struct CommentData {
            let avatarImage: UIImage?
            let name: String
            let text: String
        }
    }
    
    func configure(withData data: Data) {
        foodImageView.image = data.foodImage
        data.comments.suffix(2).forEach { comment in
            let commentView = CommentView()
            let data: CommentView.CommentData = .init(avatar: comment.avatarImage, name: comment.name, text: comment.text)
            commentView.configure(withData: data)
            commentsStackView.addArrangedSubview(commentView)
        }
        
        likeCountLabel.text = "\(data.likeCount)"
        saveCountLabel.text = "\(data.savesCount)"

        likeIcon.image = data.isLiked ? UIImage(named: "icon_heart_active") : UIImage(named: "icon_heart")
        saveIcon.image = data.isSaved ? UIImage(named: "icon_save_active") : UIImage(named: "icon_save_active")
        
        let createdAtDate = Date(timeIntervalSince1970: TimeInterval(data.createdAt))
        
        createdAtLabel.text = createdAtDate.getElapsedInterval()
        
        commentInputTextField.delegate = self
        
        likeButton.addTarget(self, action: #selector(likeButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc private func likeButtonTapped(_ sender: UIButton) {
        actions?(.likeTapped)
    }
    
}

// MARK: - UITextFieldDelegate

extension FoodTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.isEmpty {
            return false
        }
        
        actions?(.sendText(text: textField.text ?? ""))
        textField.text = ""
        textField.resignFirstResponder()
        return true
    }
    
}

//
//  CommentView.swift
//  DietTestApp
//
//  Created by Maksym Horbenko on 06.07.2021.
//

import UIKit
import SnapKit

final class CommentView: UIView {
    
    // MARK: - UI
    
    let contentStackView = UIStackView().apply {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .fill
        $0.spacing = 12
    }
    
    let avatarImageView = UIImageView().apply {
        $0.contentMode = .scaleAspectFill
    }
    
    let textLabel = UILabel().apply {
        $0.font = .main(size: 15)
        $0.textColor = UIColor(hexString: "#E6E6E6")
        $0.numberOfLines = 2
    }
    
    // MARK: - Init
    
    init() {
        super.init(
            frame: CGRect(
                x: 0,
                y: 0,
                width: UIView.noIntrinsicMetric,
                height: UIView.noIntrinsicMetric
            )
        )
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        addSubview(contentStackView)
        contentStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentStackView.addArrangedSubviews([avatarImageView, textLabel])
        
        avatarImageView.snp.makeConstraints { make in
            make.size.equalTo(40)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.layer.cornerRadius = 20
    }
    
    struct CommentData {
        let avatar: UIImage?
        let name: String
        let text: String
    }
    
    // MARK: - Configure
    
    func configure(withData commentData: CommentData) {
        avatarImageView.image = commentData.avatar
        let attributedText = configureTextAttributedString(name: commentData.name, text: commentData.text)
        textLabel.attributedText = attributedText.joined(separator: " ")
    }
    
    private func configureTextAttributedString(name: String, text: String) -> [NSAttributedString] {
        var attributedText: [NSAttributedString] = []
        attributedText.append(.init(string: name, attributes: [.font: UIFont.main(weight: .bold, size: 15),
                                                               .foregroundColor: UIColor(hexString: "#E6E6E6") ?? .white]))
        attributedText.append(.init(string: text, attributes: [.font: UIFont.main(weight: .regular, size: 15),
                                                               .foregroundColor: UIColor(hexString: "#E6E6E6") ?? .white]))
        return attributedText
    }
    
}

//
//  FeedNavigationView.swift
//  DietTestApp
//
//  Created by Maksym Horbenko on 07.07.2021.
//

import UIKit
import SnapKit

final class FeedNavigationView: UIView {
    
    // MARK: - UI
    
    private let contentStackView = UIStackView().apply {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .equalSpacing
        $0.spacing = 6
    }
    
    let titleLabel = UILabel().apply {
        $0.font = .main(weight: .medium, size: 24)
        $0.textColor = UIColor(hexString: "#FFFFFF")
        $0.numberOfLines = 2
    }
    
    let rightAddButton = UIButton().apply {
        $0.setImage(#imageLiteral(resourceName: "icon_add_new"), for: .normal)
        $0.tintColor = UIColor(hexString: "#FFFFFF")
    }
    
    // MARK: - Init
    
    let title: String
    let buttonAction: (() -> Void)?
    
    init(title: String, buttonAction: (() -> Void)?) {
        self.title = title
        self.buttonAction = buttonAction
        
        super.init(
            frame: CGRect(
                x: 0,
                y: 0,
                width: UIView.noIntrinsicMetric,
                height: UIView.noIntrinsicMetric
            )
        )
        setupLayout()
        configure()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        addSubview(contentStackView)
        contentStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(28)
            make.trailing.equalToSuperview().inset(28)
            make.bottom.equalToSuperview().inset(30)
        }
        
        contentStackView.addArrangedSubviews([titleLabel, rightAddButton])
    }
    
    private func configure() {
        titleLabel.text = title
        rightAddButton.addTarget(self, action: #selector(rightAddButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc private func rightAddButtonTapped(_ sender: UIButton) {
        buttonAction?()
    }
        
}

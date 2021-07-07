//
//  FeedContentView.swift
//  DietTestApp
//
//  Created by Maksym Horbenko on 06.07.2021.
//

import UIKit
import SnapKit

import RxSwift
import RxCocoa

import SwifterSwift

final class FeedContentView: View<FeedViewModel> {
    
    // MARK: - UI
    
    let navigationView = FeedNavigationView(title: "Good Morning", buttonAction: nil).apply {
        $0.backgroundColor = .clear
    }
    
    let feedTableView = UITableView().apply {
        $0.separatorStyle = .none
        $0.register(cellWithClass: FoodTableViewCell.self)
        $0.backgroundColor = .clear
    }
    
    let gradientLayer = CAGradientLayer(colors: [UIColor(hexString: "09090F") ?? .black,
                                                 UIColor(hexString: "191929") ?? .black],
                                        locations: [0, 1],
                                        startPoint: .init(x: 0.5, y: 1),
                                        endPoint: .init(x: 0.5, y: 0),
                                        type: .axial)
    
    // MARK: - Override methods
    
    override func style() {
        super.style()
        setupStyle()
    }
    
    override func layout() {
        setupLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if layer.sublayers?.contains(gradientLayer) == false {
            layer.insertSublayer(gradientLayer, at: 0)
            gradientLayer.frame = bounds
        }
    }
    
    // MARK: - Private hepling methods
    
    private func setupStyle() {
        backgroundColor = .black
    }
    
    private func setupLayout() {
        addSubview(navigationView)
        navigationView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(65)
        }
        
        addSubview(feedTableView)
        feedTableView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.leading.trailing.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    // MARK: - Public methods
    
    
    
}

//
//  SplashContentView.swift
//  DietTestApp
//
//  Created by Maksym Horbenko on 06.07.2021.
//

import UIKit
import SnapKit

final class SplashContentView: View<SplashViewModel> {
    
    // MARK: - Override methods
    
    override func style() {
        super.style()
        setupStyle()
    }
    
    override func layout() {

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: - Private hepling methods
    
    private func setupStyle() {
        backgroundColor = .black
    }
    
    // MARK: - Public methods
    
    
}

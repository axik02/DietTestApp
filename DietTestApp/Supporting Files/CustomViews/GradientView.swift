//
//  GradientView.swift
//  DietTestApp
//
//  Created by Maksym Horbenko on 06.07.2021.
//

import UIKit

final class GradientView: UIView {
    
    private let gradientLayer = CAGradientLayer()
    
    let colors: [CGColor]
    let startPoint: CGPoint
    let endPoint: CGPoint
    let locations: [NSNumber]
    
    init(colors: [CGColor], startPoint: CGPoint, endPoint: CGPoint, locations: [NSNumber]) {
        self.colors = colors
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.locations = locations
        
        super.init(
            frame: CGRect(
                x: 0,
                y: 0,
                width: UIView.noIntrinsicMetric,
                height: UIView.noIntrinsicMetric
            )
        )
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        createGradient()
    }
    
    private func createGradient() {
        gradientLayer.colors = colors
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.locations = locations
        gradientLayer.frame = frame
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
}

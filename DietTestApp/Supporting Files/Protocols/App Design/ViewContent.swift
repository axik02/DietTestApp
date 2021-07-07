//
//  ViewContent.swift
//  DietTestApp
//
//  Created by Maksym Horbenko on 06.07.2021.
//

import UIKit

protocol ContentView: UIView {
    associatedtype T: ViewModel
    var viewModel: T { get }

    func style()
    func configure()
    func layout()
}

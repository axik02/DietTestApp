//
//  View.swift
//  DietTestApp
//
//  Created by Maksym Horbenko on 06.07.2021.
//

import UIKit

class View<ViewModelType: ViewModel>: UIView, ContentView {

    let viewModel: ViewModelType

    init(viewModel: ViewModelType) {
        self.viewModel = viewModel

        super.init(
            frame: CGRect(
                x: 0,
                y: 0,
                width: UIView.noIntrinsicMetric,
                height: UIView.noIntrinsicMetric
            )
        )

        style()
        configure()
        layout()
    }

    func style() {}
    func configure() {}
    func layout() {}

    required init?(coder: NSCoder) {
        return nil
    }
}

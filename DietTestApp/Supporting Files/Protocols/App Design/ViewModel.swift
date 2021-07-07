//
//  ViewModel.swift
//  DietTestApp
//
//  Created by Maksym Horbenko on 06.07.2021.
//

protocol ViewModel {
    func onLoad()
    func onAppear()
    func onDisappear()
}

extension ViewModel {
    func onLoad() {}
    func onAppear() {}
    func onDisappear() {}
}

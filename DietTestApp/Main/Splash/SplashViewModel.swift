//
//  SplashViewModel.swift
//  DietTestApp
//
//  Created by Maksym Horbenko on 06.07.2021.
//

import Foundation

final class SplashViewModel: ViewModel {
    enum State {
        case loading
    }
    var state: ((State?) -> Void)?
    
    enum Action {
        case perform(segue: SplashViewControllerSegue)
    }
    var actions: ((Action) -> Void)?
    
    func onLoad() {
        state?(.loading)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.state?(.none)
            self.actions?(.perform(segue: .mainTab))
        })
    }
}

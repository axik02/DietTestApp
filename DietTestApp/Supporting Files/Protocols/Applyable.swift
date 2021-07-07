//
//  Applyable.swift
//  DietTestApp
//
//  Created by Maksym Horbenko on 06.07.2021.
//

import Foundation

protocol Applyable { }

extension Applyable {
    // MARK: - Appearance
    @discardableResult
    func apply(_ configuration: (Self) throws -> Void) rethrows -> Self {
        try configuration(self)
        return self
    }
}

extension NSObject: Applyable { }

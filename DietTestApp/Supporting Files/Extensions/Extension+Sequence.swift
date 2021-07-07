//
//  Extension+Sequence.swift
//  DietTestApp
//
//  Created by Maksym Horbenko on 07.07.2021.
//

import Foundation

extension Sequence where Iterator.Element: NSAttributedString {
    /// Returns a new attributed string by concatenating the elements of the sequence, adding the given separator between each element.
    /// - parameters:
    ///     - separator: A string to insert between each of the elements in this sequence. The default separator is an empty string.
    func joined(separator: NSAttributedString = NSAttributedString(string: "")) -> NSAttributedString {
        var isFirst = true
        return self.reduce(NSMutableAttributedString()) {
            (r, e) in
            if isFirst {
                isFirst = false
            } else {
                r.append(separator)
            }
            r.append(e)
            return r
        }
    }

    /// Returns a new attributed string by concatenating the elements of the sequence, adding the given separator between each element.
    /// - parameters:
    ///     - separator: A string to insert between each of the elements in this sequence. The default separator is an empty string.
    func joined(separator: String = "") -> NSAttributedString {
        return joined(separator: NSAttributedString(string: separator))
    }
}

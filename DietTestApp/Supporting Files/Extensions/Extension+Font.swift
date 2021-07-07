//
//  Extension+Font.swift
//  DietTestApp
//
//  Created by Maksym Horbenko on 06.07.2021.
//

import UIKit

extension UIFont {
    
    class func main(weight: UIFont.Weight = .regular, isItalic: Bool = false, size: CGFloat) -> UIFont {
        circular(weight: weight, isItalic: isItalic, size: size) ?? UIFont.systemFont(ofSize: size, weight: weight)
    }
    
    class func circular(weight: UIFont.Weight = .regular, isItalic: Bool = false, size: CGFloat) -> UIFont? {
        switch weight {
        case .thin:
            return UIFont(name: isItalic ? "CircularStd-BookItalic" : "CircularStd-Book", size: size)
        case .light:
            return UIFont(name: isItalic ? "CircularStd-BookItalic" : "CircularStd-Book", size: size)
        case .medium:
            return UIFont(name: isItalic ? "CircularStd-MediumItalic" : "CircularStd-Medium", size: size)
        case .regular:
            return UIFont(name: isItalic ? "CircularStd-BookItalic" : "CircularStd-Book", size: size)
        case .bold:
            return UIFont(name: isItalic ? "CircularStd-BoldItalic" : "CircularStd-Bold", size: size)
        case .semibold:
            return UIFont(name: isItalic ? "CircularStd-BoldItalic" : "CircularStd-Bold", size: size)
        case .black:
            return UIFont(name: isItalic ? "CircularStd-BlackItalic" : "CircularStd-Black", size: size)
        case .heavy:
            return UIFont(name: isItalic ? "CircularStd-BoldItalic" : "CircularStd-Bold", size: size)
        default:
            return UIFont(name: isItalic ? "CircularStd-BookItalic" : "CircularStd-Book", size: size)
        }
    }
    
}

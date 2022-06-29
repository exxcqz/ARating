//
//  UIFont+App.swift
//  ARating
//
//  Created by Nikita Gavrikov on 29.06.2022.
//

import UIKit

extension UIFont {

    static func font(name: String, size: CGFloat) -> UIFont {
        return .init(name: name, size: size) ?? .systemFont(ofSize: size)
    }

    static func oroTextSemiboldFont(ofSize size: CGFloat) -> UIFont {
        return .font(name: "SFProText-Semibold", size: size)
    }

    static func proDisplaySemiboldItalicFont(ofSize size: CGFloat) -> UIFont {
        return .font(name: "SFProDisplay-SemiboldItalic", size: size)
    }

    static func proDisplaySemiboldFont(ofSize size: CGFloat) -> UIFont {
        return .font(name: "SFProDisplay-Semibold", size: size)
    }

    static func proDisplayRegularFont(ofSize size: CGFloat) -> UIFont {
        return .font(name: "SFProDisplay-Regular", size: size)
    }

    static func proDisplayBoldFont(ofSize size: CGFloat) -> UIFont {
        return .font(name: "SFProDisplay-Bold", size: size)
    }

    static func proDisplayMediumFont(ofSize size: CGFloat) -> UIFont {
        return .font(name: "SFProDisplay-Medium", size: size)
    }
}

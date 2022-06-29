//
//  UIColor+Rgb.swift
//  ARating
//
//  Created by Nikita Gavrikov on 29.06.2022.
//

import UIKit

extension UIColor {

    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) {
        self.init(
            red: r / 255.0,
            green: g / 255.0,
            blue: b / 255.0,
            alpha: alpha
        )
    }
}

//
//  UIColor+Extenstion.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 28.11.2021.
//

import UIKit

extension UIColor {

    func mix(with color: UIColor, amount: CGFloat) -> UIColor {
        var red1: CGFloat = 0
        var green1: CGFloat = 0
        var blue1: CGFloat = 0
        var alpha1: CGFloat = 0
        var red2: CGFloat = 0
        var green2: CGFloat = 0
        var blue2: CGFloat = 0
        var alpha2: CGFloat = 0

        getRed(&red1, green: &green1, blue: &blue1, alpha: &alpha1)
        color.getRed(&red2, green: &green2, blue: &blue2, alpha: &alpha2)

        return UIColor(
            red: red1 * (1.0 - amount) + red2 * amount,
            green: green1 * (1.0 - amount) + green2 * amount,
            blue: blue1 * (1.0 - amount) + blue2 * amount,
            alpha: alpha1
        )
    }
}

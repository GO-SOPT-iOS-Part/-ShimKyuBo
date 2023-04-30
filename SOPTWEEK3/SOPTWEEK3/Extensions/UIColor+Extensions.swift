//
//  UIColor+Extensions.swift
//  SOPTWEEK3
//
//  Created by KYUBO A. SHIM on 2023/04/30.
//

import UIKit.UIColor

    // MARK: - Extension for shifting Hex Code to UIColor
extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        assert(hexFormatted.count == 6, "Invalid hex code used.")
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: alpha)
    }
}

extension UIColor {
    static var MainColor: UIColor {
        return UIColor(hex: "#FF143C")
    }
    
    static var BrandGray1: UIColor {
        return UIColor(hex: "#D6D6D6")
    }
    
    static var BrandGray2: UIColor {
        return UIColor(hex: "#9C9C9C")
    }
    
    static var BrandGray3: UIColor {
        return UIColor(hex: "#626262")
    }
    
    static var BrandGray4: UIColor {
        return UIColor(hex: "#2E2E2E")
    }
}

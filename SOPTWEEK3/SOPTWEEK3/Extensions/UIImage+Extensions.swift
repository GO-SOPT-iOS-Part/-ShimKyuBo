//
//  UIImage+Extensions.swift
//  SOPTWEEK3
//
//  Created by KYUBO A. SHIM on 2023/04/30.
//

import UIKit.UIImage

extension UIImage {
    static func load(name: String) -> UIImage {
        guard let imageToGet = UIImage(named: name) else {
            print("Failed Loading Image: \(name)")
            return UIImage()
        }
        
        return imageToGet
    }
}

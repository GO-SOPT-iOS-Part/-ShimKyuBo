//
//  UICollectionViewCell+Enxtensions.swift
//  SOPTWEEK3
//
//  Created by KYUBO A. SHIM on 2023/05/01.
//

import UIKit.UICollectionViewCell

extension UICollectionViewCell {
    static var cellIdentifier: String {
        return String(describing: self)
    }
}

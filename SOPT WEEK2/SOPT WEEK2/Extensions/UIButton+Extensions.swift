//
//  UIButton+Extensions.swift
//  SOPT WEEK2
//
//  Created by KYUBO A. SHIM on 2023/04/14.
//

import UIKit

extension UIButton {
    func setUnderline() {
        guard let title = self.title(for: .normal) else { return }
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: title.count))
        attributedString.addAttribute(.underlineColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: title.count))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: title.count))
        self.setAttributedTitle(attributedString, for: .normal)
    }
}

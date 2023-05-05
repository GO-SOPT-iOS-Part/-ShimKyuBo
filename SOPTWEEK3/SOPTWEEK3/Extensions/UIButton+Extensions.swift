//
//  UIButton+Extensions.swift
//  SOPTWEEK3
//
//  Created by KYUBO A. SHIM on 2023/04/30.
//

import UIKit.UIButton

    /// Appearances
extension UIButton {
    // Set a Single UnderLine for UIButton
    func setUnderline() {
        guard let title = self.title(for: .normal) else { return }
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: title.count))
        attributedString.addAttribute(.underlineColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: title.count))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: title.count))
        self.setAttributedTitle(attributedString, for: .normal)
    }
    
    // Set Image right to title text
    func addImageToRight(title: String, font: Pretendard, fontSize: UIFont.TextStyle, systemImageName: String, systemImageSize: CGFloat) {
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: systemImageSize)
        self.setTitle(title, for: .normal)
        self.setImage(UIImage(systemName: systemImageName, withConfiguration: symbolConfiguration), for: .normal)
        self.titleLabel?.font = .CustomPretendarFont(font, forTextStyle: fontSize)
        self.semanticContentAttribute = .forceRightToLeft
    }
}
    
    /// Functions
extension UIControl {
    /// Closure to Action using UIControl
    func addAction(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping () -> ()) {
        addAction(UIAction { (action: UIAction) in closure() }, for: controlEvents)
    }
}

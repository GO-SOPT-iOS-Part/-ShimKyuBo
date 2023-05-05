//
//  UILabel+Extensions.swift
//  SOPTWEEK3
//
//  Created by KYUBO A. SHIM on 2023/05/01.
//

import UIKit.UILabel

extension UILabel {
    func addImageBeforeText(imageName: String, text: String) {
        let attributedString = NSMutableAttributedString(string: "")
        let imageToAttach = NSTextAttachment()
        imageToAttach.image = UIImage.load(name: imageName)
        imageToAttach.bounds = CGRect(x: 0, y: 0, width: 13, height: 13)
        attributedString.append(NSAttributedString(attachment: imageToAttach))
        attributedString.append(NSAttributedString(string: text))
        self.attributedText = attributedString
        self.sizeToFit()
    }
    
    func addImagesMiddleOfText(firstImage: String, secondImage:String, formerText: String, latterText: String) {
        let attributedString = NSMutableAttributedString()
        let firstImage = NSTextAttachment(image: UIImage.load(name: firstImage))
        firstImage.bounds = CGRect(x: -10, y: 0, width: 30, height: 15)
        let secondImage = NSTextAttachment(image: UIImage.load(name: secondImage))
        secondImage.bounds = CGRect(x: 0, y: 0, width: 30, height: 15)
        
        attributedString.append(NSAttributedString(string: formerText))
        attributedString.append(NSAttributedString(attachment: firstImage))
        attributedString.append(NSAttributedString(attachment: secondImage))
        attributedString.append(NSAttributedString(string: latterText))
        attributedString.addAttribute(.font, value: UIFont.CustomPretendarFont(.SemiBold, forTextStyle: .subheadline), range: NSRange(location: 0, length: attributedString.length))
        
        self.attributedText = attributedString
        self.sizeToFit()
    }
}


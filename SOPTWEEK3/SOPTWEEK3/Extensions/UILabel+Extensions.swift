//
//  UILabel+Extensions.swift
//  SOPTWEEK3
//
//  Created by KYUBO A. SHIM on 2023/05/01.
//

import UIKit.UILabel

extension UILabel {
//    func addImageBeforeText(imageName: String, text: String) {
//        let attributedString = NSMutableAttributedString(string: "")
//        let imageToAttach = NSTextAttachment()
//        imageToAttach.
//        imageToAttach.image = UIImage.load(name: imageName)
//        imageToAttach.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
//        attributedString.append(NSAttributedString(attachment: imageToAttach))
//        attributedString.append(NSAttributedString(string: text))
//        self.attributedText = attributedString
//        self.sizeToFit()
//    }
    
    func addImagesMiddleOfText(firstImage: String, secondImage:String, formerText: String, latterText: String) {
        let attributedString = NSMutableAttributedString()
//        let formerAttributedString = NSMutableAttributedString(string: formerText)
//        let latterAttributedString = NSMutableAttributedString(string: latterText)
        let firstImage = NSTextAttachment(image: UIImage.load(name: firstImage))
        firstImage.bounds = CGRect(x: -10, y: 0, width: 30, height: 30)
        let secondImage = NSTextAttachment(image: UIImage.load(name: secondImage))
        secondImage.bounds = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        attributedString.append(NSAttributedString(string: formerText))
        attributedString.append(NSAttributedString(attachment: firstImage))
        attributedString.append(NSAttributedString(attachment: secondImage))
        attributedString.append(NSAttributedString(string: latterText))
        self.attributedText = attributedString
        self.sizeToFit()
    }
}


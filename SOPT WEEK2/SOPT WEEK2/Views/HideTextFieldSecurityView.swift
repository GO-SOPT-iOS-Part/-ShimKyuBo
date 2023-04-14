//
//  HideTextFieldSecurityView.swift
//  SOPT WEEK2
//
//  Created by KYUBO A. SHIM on 2023/04/14.
//

import UIKit

import SnapKit
import Then

//final class HideTextFieldSecurityView: UIButton {
//
//    private var isSelected: Bool = false {
//        didSet {
//            if isSelected {
//                imageView.image = UIImage(named: "eyeIcon")
//            } else {
//                imageView.image = UIImage(named: "eyeOpenIcon")
//            }
//        }
//    }
//
//    let imageView = UIImageView().then {
//        $0.contentMode = .scaleAspectFit
//    }
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        layouts()
//    }
//
//    private func layouts() {
//        self.addSubviews(imageView)
//
//        imageView.snp.makeConstraints {
//            $0.center.equalToSuperview()
//            $0.size.equalTo(20)
//        }
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//}

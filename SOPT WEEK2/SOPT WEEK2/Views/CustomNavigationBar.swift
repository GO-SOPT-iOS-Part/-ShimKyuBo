//
//  CustomNavigationBar.swift
//  SOPT WEEK2
//
//  Created by KYUBO A. SHIM on 2023/04/13.
//

import UIKit

import SnapKit
import Then

final class CustomNavigationBar: UIView {
    
    private let backButton = UIButton(type: .system, primaryAction: UIAction(handler: { _ in
        print("Back Button Tapped")
    })).then {
//        $0.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 3), forImageIn: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
        $0.setImage(UIImage(named: "chevronIcon"), for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        layouts()
    }
    
    private func layouts() {
        self.addSubviews(backButton)
        
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(17)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

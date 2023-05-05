//
//  ProfileFooterView.swift
//  SOPTWEEK3
//
//  Created by KYUBO A. SHIM on 2023/05/05.
//

import UIKit

class ProfileFooterView: UIView {

    private let logOutButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        basicSetup()
        setStyle()
        setLayout()
    }
    
    private func basicSetup() {
        self.backgroundColor = .clear
    }
    
    private func setStyle() {
        logOutButton.do {
            $0.setTitle("로그아웃", for: .normal)
            $0.setTitleColor(.BrandGray1, for: .normal)
            $0.layer.masksToBounds = true
            $0.layer.borderColor = UIColor.BrandGray1.cgColor
            $0.layer.borderWidth = 0.5
            $0.layer.cornerRadius = 3
            $0.titleLabel?.font = .CustomPretendarFont(.Medium, forTextStyle: .callout)
        }
    }
    
    private func setLayout() {
        self.addSubview(logOutButton)
        
        logOutButton.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  CustomNavigationBarView.swift
//  SOPTWEEK3
//
//  Created by KYUBO A. SHIM on 2023/04/30.
//

import UIKit

import SnapKit
import Then

    // MARK: - Custom Navigation View for future Seminars
final class CustomNavigationBar: UIView {
    
    lazy var backButton = UIButton(type: .system).then {
        $0.imageView?.contentMode = .scaleAspectFit
        $0.setImage(UIImage(named: "chevronIcon"), for: .normal)
    }
    
    private let alarmButton = UIButton(type: .system)
    private let settingButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setLayout()
        setStyle()
    }
    
    private func setStyle() {
        let systemConfiguration = UIImage.SymbolConfiguration(pointSize: 15)
        alarmButton.do {
            $0.setImage(UIImage(systemName: "bell", withConfiguration: systemConfiguration), for: .normal)
            $0.contentMode = .scaleAspectFit
            $0.tintColor = .BrandGray2
            $0.isHidden = true
        }
        
        settingButton.do {
            $0.setImage(UIImage(systemName: "gearshape", withConfiguration: systemConfiguration), for: .normal)
            $0.contentMode = .scaleAspectFit
            $0.tintColor = .BrandGray2
            $0.isHidden = true
        }
    }
    
    private func setLayout() {
        self.addSubviews(backButton, settingButton, alarmButton)
        
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(17)
        }
        
        settingButton.snp.makeConstraints {
            $0.centerY.equalTo(backButton.snp.centerY)
            $0.trailing.equalToSuperview().inset(25)
        }
        
        alarmButton.snp.makeConstraints {
            $0.centerY.equalTo(backButton.snp.centerY)
            $0.trailing.equalTo(settingButton.snp.leading).offset(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomNavigationBar {
    func showButtons() {
        alarmButton.isHidden = false
        settingButton.isHidden = false
    }
}

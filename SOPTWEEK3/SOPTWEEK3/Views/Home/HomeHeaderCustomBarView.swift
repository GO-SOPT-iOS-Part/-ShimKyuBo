//
//  HomeHeadCustomBarView.swift
//  SOPTWEEK3
//
//  Created by KYUBO A. SHIM on 2023/04/30.
//

import UIKit

import SnapKit
import Then

class HomeHeaderCustomBarView: UIView {

    private let mainLogoImageView: UIImageView = UIImageView()
    private let shareButton: UIButton = UIButton(type: .custom)
    private let profileButton: UIButton = UIButton(type: .custom)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        basicSetup()
        setStyle()
        setLayout()
    }
    
    private func basicSetup() {
        self.backgroundColor = .clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileButton.layer.cornerRadius = self.profileButton.frame.width/2
    }
    
    private func setStyle() {
        mainLogoImageView.do {
            $0.image = UIImage.load(name: "TVingHomeLogo")
            $0.contentMode = .scaleAspectFit
        }
        
        shareButton.do {
            let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
            let iconImage = UIImage(systemName: "airplayvideo", withConfiguration: symbolConfiguration)
            $0.setImage(iconImage, for: .normal)
            $0.contentMode = .scaleAspectFit
            $0.tintColor = .white
            $0.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        }
        
        profileButton.do {
            $0.setImage(UIImage.load(name: "BearsLogo"), for: .normal)
            $0.backgroundColor = .clear
            $0.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        }
    }
    
    private func setLayout() {
        self.addSubviews(mainLogoImageView, profileButton, shareButton)
        
        mainLogoImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(20)
            $0.width.equalTo(80)
        }
        
        profileButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(10)
            $0.size.equalTo(30)
            $0.centerY.equalTo(mainLogoImageView.snp.centerY)
        }
        
        shareButton.snp.makeConstraints {
            $0.trailing.equalTo(profileButton.snp.leading).offset(-30)
            $0.centerY.equalTo(profileButton.snp.centerY)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeHeaderCustomBarView {
    @objc
    private func shareButtonTapped() {
        print("AirPlay Tapped.")
    }
    
    @objc
    private func profileButtonTapped() {
        print("Profile Button Tapped.")
    }
}

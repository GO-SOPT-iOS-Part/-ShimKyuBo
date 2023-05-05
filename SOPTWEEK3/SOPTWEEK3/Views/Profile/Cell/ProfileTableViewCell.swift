//
//  ProfileTableViewCell.swift
//  SOPTWEEK3
//
//  Created by KYUBO A. SHIM on 2023/05/05.
//

import UIKit

import SnapKit
import Then

final class ProfileTableViewCell: UITableViewCell {
    
    private let profileMenuLabel = UILabel()
    private let nextSymbolImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        basicSetup()
        setStyle()
        setLayout()
    }
    
    private func basicSetup() {
        self.backgroundColor = .clear
    }
    
    private func setStyle() {
        profileMenuLabel.do {
            $0.font = .CustomPretendarFont(.Medium, forTextStyle: .callout)
            $0.textColor = .BrandGray1
        }
        
        nextSymbolImageView.do {
            let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 20)
            $0.image = UIImage(systemName: "chevron.right", withConfiguration: symbolConfiguration)
            $0.tintColor = .BrandGray1
        }
    }
    
    private func setLayout() {
        self.addSubviews(profileMenuLabel, nextSymbolImageView)
        
        profileMenuLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(18)
        }
        
        nextSymbolImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(18)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileTableViewCell {
    func configureCell(profileTitles: String) {
        profileMenuLabel.text = profileTitles
    }
}

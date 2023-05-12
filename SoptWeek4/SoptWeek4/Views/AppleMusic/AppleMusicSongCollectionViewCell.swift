//
//  AppleMusicCatalogCollectionViewCell.swift
//  SoptWeek4
//
//  Created by KYUBO A. SHIM on 2023/05/11.
//

import UIKit

class AppleMusicSongCollectionViewCell: UICollectionViewCell {
    
    private let albumCoverImageView = UIImageView()
    private let descriptionBoxView = UIView()
    private let descriptionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConfiguration()
        setStyle()
        setLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 20
    }
    
    private func setConfiguration() {
        self.backgroundColor = .clear
    }
    
    private func setStyle() {
        albumCoverImageView.do {
            $0.contentMode = .scaleAspectFill
            $0.layer.masksToBounds = true
            $0.backgroundColor = .systemGray2
        }
        
        descriptionBoxView.do {
            $0.backgroundColor = .white.withAlphaComponent(0.6)
        }
        
        descriptionLabel.do {
            $0.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
            $0.textColor = .white
            $0.numberOfLines = 1
        }
    }
    
    private func setLayout() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

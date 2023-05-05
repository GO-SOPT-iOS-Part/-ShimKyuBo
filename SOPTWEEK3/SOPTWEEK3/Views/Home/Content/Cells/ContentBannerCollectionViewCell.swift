//
//  ContentBannerCollectionViewCell.swift
//  SOPTWEEK3
//
//  Created by KYUBO A. SHIM on 2023/05/03.
//

import UIKit

import SnapKit
import Then

final class ContentBannerCollectionViewCell: UICollectionViewCell {
    
    private let bannerImageView = UIImageView()
    
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
        bannerImageView.do {
            $0.contentMode = .scaleAspectFill
            $0.backgroundColor = .systemGray6
            $0.layer.masksToBounds = true
        }
    }
    
    private func setLayout() {
        self.addSubview(bannerImageView)
        
        bannerImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().inset(15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ContentBannerCollectionViewCell {
    func configureCell(imageName: String) {
        bannerImageView.image = UIImage.load(name: imageName)
    }
}

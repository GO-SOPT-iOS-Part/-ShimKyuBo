//
//  ContentPosterCollectionViewCell.swift
//  SOPTWEEK3
//
//  Created by KYUBO A. SHIM on 2023/05/03.
//

import UIKit

import SnapKit
import Then

final class ContentPosterCollectionViewCell: UICollectionViewCell {
    
    private let posterImageView = UIImageView()
    private let posterNameLabel = UILabel()
    
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
        posterImageView.do {
            $0.backgroundColor = .systemGray6
            $0.contentMode = .scaleAspectFill
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 3
        }
        
        posterNameLabel.do {
            $0.font = .CustomPretendarFont(.Medium, forTextStyle: .caption2)
            $0.textColor = .BrandGray2
            $0.textAlignment = .left
            $0.numberOfLines = 1
        }
    }
    
    private func setLayout() {
        self.addSubviews(posterImageView, posterNameLabel)
        
        posterImageView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(posterImageView.snp.width).dividedBy(0.7)
        }
        
        posterNameLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(posterImageView.snp.bottom).offset(5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ContentPosterCollectionViewCell {
    func configureCell(imageName: String, posterTitle: String) {
        posterImageView.image = UIImage.load(name: imageName)
        posterNameLabel.text = posterTitle
    }
}

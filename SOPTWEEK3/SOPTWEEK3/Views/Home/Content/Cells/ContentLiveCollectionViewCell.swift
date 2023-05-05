//
//  ContentLiveCollectionViewCell.swift
//  SOPTWEEK3
//
//  Created by KYUBO A. SHIM on 2023/05/03.
//

import UIKit

import SnapKit
import Then

final class ContentLiveCollectionViewCell: UICollectionViewCell {
    
    private let channelImageView = UIImageView()
    private let rankLabel = UILabel()
    private let posterNameLabel = UILabel()
    private let updateIndicatorDot = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        basicSetup()
        setStyle()
        setLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateIndicatorDot.layer.cornerRadius = self.updateIndicatorDot.frame.width/2
    }
    
    private func basicSetup() {
        self.backgroundColor = .clear
    }
    
    private func setStyle() {
        channelImageView.do {
            $0.contentMode = .scaleAspectFill
            $0.backgroundColor = .systemGray6
            $0.layer.cornerRadius = 3
            $0.layer.masksToBounds = true
        }
        
        rankLabel.do {
            $0.font = .CustomPretendarFont(.Black, forTextStyle: .largeTitle)
            $0.textColor = .white
            $0.layer.shadowOffset = CGSize(width: 3, height: 3)
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOpacity = 0.8
            $0.layer.shadowRadius = 3
        }
        
        posterNameLabel.do {
            $0.font = .CustomPretendarFont(.Medium, forTextStyle: .caption2)
            $0.textColor = .BrandGray2
            $0.textAlignment = .left
            $0.numberOfLines = 1
        }
        
        updateIndicatorDot.do {
            $0.backgroundColor = .systemRed
        }
    }
    
    private func setLayout() {
        self.addSubviews(channelImageView, rankLabel, posterNameLabel, updateIndicatorDot)
        
        channelImageView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(channelImageView.snp.width).dividedBy(2)
        }
        
        rankLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(2)
            $0.bottom.equalTo(channelImageView.snp.bottom).offset(20)
        }
        
        posterNameLabel.snp.makeConstraints {
            $0.leading.equalTo(rankLabel.snp.trailing).offset(3)
            $0.top.equalTo(channelImageView.snp.bottom).offset(5)
        }
        
        updateIndicatorDot.snp.makeConstraints {
            $0.size.equalTo(2.5)
            $0.centerX.equalTo(posterNameLabel.snp.trailing).offset(3)
            $0.centerY.equalTo(posterNameLabel.snp.top).offset(3)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ContentLiveCollectionViewCell {
    func configureCell(imageName: String, posterTitle: String, rank: Int) {
        channelImageView.image = UIImage.load(name: imageName)
        posterNameLabel.text = posterTitle
        rankLabel.text = String(rank)
    }
}

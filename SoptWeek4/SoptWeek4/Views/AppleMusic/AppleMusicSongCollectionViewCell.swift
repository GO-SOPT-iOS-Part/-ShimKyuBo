//
//  AppleMusicCatalogCollectionViewCell.swift
//  SoptWeek4
//
//  Created by KYUBO A. SHIM on 2023/05/11.
//

import UIKit

class AppleMusicSongCollectionViewCell: UICollectionViewCell {
    
    private let albumCoverImageView = UIImageView()
    private let descriptionSongTitleLabel = UILabel()
    private let descriptionArtistLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setConfiguration()
        setStyle()
        setLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
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
        
        descriptionSongTitleLabel.do {
            $0.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
            $0.textColor = .black
            $0.numberOfLines = 1
        }
        
        descriptionArtistLabel.do {
            $0.font = UIFont.systemFont(ofSize: 12, weight: .medium)
            $0.textColor = .gray
            $0.numberOfLines = 1
        }
    }
    
    private func setLayout() {
        self.addSubview(albumCoverImageView)
        self.addSubview(descriptionSongTitleLabel)
        self.addSubview(descriptionArtistLabel)
        
        albumCoverImageView.snp.makeConstraints {
            $0.width.equalTo(self.frame.width)
            $0.top.equalToSuperview()
            $0.height.equalTo(albumCoverImageView.snp.width)
            $0.centerX.equalToSuperview()
        }
        
        descriptionSongTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(albumCoverImageView.snp.bottom).offset(3)
        }
        
        descriptionArtistLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(descriptionSongTitleLabel.snp.bottom).offset(2)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AppleMusicSongCollectionViewCell {
    func cofigureCell(albumImage: UIImage, song: String, artist: String) {
        albumCoverImageView.image = albumImage
        descriptionSongTitleLabel.text = song
        descriptionArtistLabel.text = artist
    }
}

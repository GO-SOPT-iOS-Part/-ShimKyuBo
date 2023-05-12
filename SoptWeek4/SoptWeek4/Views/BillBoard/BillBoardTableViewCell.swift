//
//  BillBoardTableViewCell.swift
//  SoptWeek4
//
//  Created by KYUBO A. SHIM on 2023/05/10.
//

import UIKit

class BillBoardTableViewCell: UITableViewCell {
    
    private let albumImageView = UIImageView()
    private let rankLabel = UILabel()
    private let artistNameLabel = UILabel()
    private let songNameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConfiguration()
        setStyle()
        setLayout()
    }
    
    private func setConfiguration() {
        self.backgroundColor = .clear
    }
    
    private func setStyle() {
        albumImageView.do {
            $0.contentMode = .scaleAspectFill
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 4
            $0.backgroundColor = .white.withAlphaComponent(0.4)
        }
        
        rankLabel.do {
            $0.font = UIFont.systemFont(ofSize: 14, weight: .light)
            $0.textColor = .white
            $0.numberOfLines = 1
        }
        
        artistNameLabel.do {
            $0.font = UIFont.systemFont(ofSize: 15, weight: .medium)
            $0.textColor = .systemGray
            $0.numberOfLines = 1
        }
        
        songNameLabel.do {
            $0.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
            $0.textColor = .white
            $0.numberOfLines = 1
        }
    }
    
    private func setLayout() {
        self.addSubview(rankLabel)
        self.addSubview(albumImageView)
        self.addSubview(songNameLabel)
        self.addSubview(artistNameLabel)
        
        rankLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(25)
            $0.width.equalTo(25)
        }
        
        albumImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(rankLabel.snp.trailing).offset(10)
            $0.height.equalToSuperview().dividedBy(1.1)
            $0.width.equalTo(albumImageView.snp.height)
        }
        
        songNameLabel.snp.makeConstraints {
            $0.leading.equalTo(albumImageView.snp.trailing).offset(10)
            $0.centerY.equalToSuperview().offset(-10)
            $0.trailing.equalToSuperview().inset(15)
        }
        
        artistNameLabel.snp.makeConstraints {
            $0.leading.equalTo(albumImageView.snp.trailing).offset(10)
            $0.centerY.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().inset(15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BillBoardTableViewCell {
    func configureCell(image: UIImage?, rank: Int, artistName: String, songName: String) {
        let rankString = String(rank)
        albumImageView.image = image
        rankLabel.text = rankString
        artistNameLabel.text = artistName
        songNameLabel.text = songName
    }
}

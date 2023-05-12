//
//  BillBoardDetailViewController.swift
//  SoptWeek4
//
//  Created by KYUBO A. SHIM on 2023/05/10.
//

import UIKit

class BillBoardDetailViewController: UIViewController {

    private let albumImage = UIImageView()
    private let artistName = UILabel()
    private let songName = UILabel()
    private let playButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfiguration()
        setStyle()
        setLayout()
    }
    
    private func setConfiguration() {
        view.backgroundColor = .black
    }
    
    private func setStyle() {
        albumImage.do {
            $0.contentMode = .scaleAspectFill
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 12
        }
        
        songName.do {
            $0.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
            $0.textColor = .white
        }
        
        artistName.do {
            $0.font = UIFont.systemFont(ofSize: 17, weight: .medium)
            $0.textColor = .gray
        }
        
        playButton.do {
            $0.setImage(UIImage(systemName: "play.circle"), for: .normal)
            $0.setImage(UIImage(systemName: "pause.circle.fill"), for: .selected)
        }
    }
    
    private func setLayout() {
        view.addSubview(albumImage)
        view.addSubview(songName)
        view.addSubview(artistName)
        view.addSubview(playButton)
        
        albumImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(50)
            $0.size.equalTo(200)
        }
        
        songName.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(30)
            $0.top.equalTo(albumImage.snp.bottom).offset(80)
        }
        
        artistName.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(30)
            $0.top.equalTo(songName.snp.bottom).offset(5)
        }
        
        playButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(100)
            $0.size.equalTo(40)
        }
    }
}

extension BillBoardDetailViewController {
    func passDatas(image: UIImage, artist: String, song: String) {
        albumImage.image = image
        artistName.text = artist
        songName.text = song
    }
}

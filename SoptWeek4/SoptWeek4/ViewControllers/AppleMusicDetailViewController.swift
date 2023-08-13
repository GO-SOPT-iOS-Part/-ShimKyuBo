//
//  AppleMusicDetailViewController.swift
//  SoptWeek4
//
//  Created by KYUBO A. SHIM on 2023/05/11.
//

import UIKit

class AppleMusicDetailViewController: UIViewController {

    private var isPlaying: Bool = false {
        didSet {
            if isPlaying == true {
                changeButtonStyle(imageName: "pause.fill")
            } else {
                changeButtonStyle(imageName: "play.fill")
            }
        }
    }
    
    private let sc = UIImage.SymbolConfiguration(pointSize: 30)
    private let scT = UIImage.SymbolConfiguration(pointSize: 25)
    private let contentBox = UIView()
    
    private let albumImage = UIImageView()
    private let artistName = UILabel()
    private let songName = UILabel()
    private let playButton = UIButton(type: .system)
    private let previousButton = UIButton(type: .system)
    private let nextButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        setConfiguration()
        setStyle()
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
 
    private func setConfiguration() {
        view.backgroundColor = UIColor(red: 240, green: 240, blue: 240, alpha: 1)
    }
    
    private func setStyle() {
        albumImage.do {
            $0.contentMode = .scaleAspectFill
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 12
        }
        
        contentBox.do {
            $0.backgroundColor = .systemGray6
            $0.layer.cornerRadius = 12
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOffset = CGSize(width: 0, height: 3)
            $0.layer.shadowOpacity = 0.9
            $0.layer.shadowRadius = 6
        }
        
        songName.do {
            $0.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
            $0.textColor = .black
        }
        
        artistName.do {
            $0.font = UIFont.systemFont(ofSize: 19, weight: .medium)
            $0.textColor = .gray
        }
        
        playButton.do {
            $0.setImage(UIImage(systemName: "play.fill", withConfiguration: sc), for: .normal)
            $0.tintColor = .black
            $0.addTarget(self, action: #selector(playTapped), for: .touchUpInside)
        }
        
        previousButton.do {
            $0.setImage(UIImage(systemName: "backward.fill", withConfiguration: scT), for: .normal)
            $0.tintColor = .black
        }
        
        nextButton.do {
            $0.setImage(UIImage(systemName: "forward.fill", withConfiguration: scT), for: .normal)
            $0.tintColor = .black
        }
    }
    
    private func setLayout() {
        view.addSubview(contentBox)
        view.addSubview(albumImage)
        view.addSubview(songName)
        view.addSubview(artistName)
        view.addSubview(playButton)
        view.addSubview(previousButton)
        view.addSubview(nextButton)
        
        albumImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            $0.size.equalTo(200)
        }
        
        contentBox.snp.makeConstraints {
            $0.center.equalTo(albumImage.snp.center)
            $0.size.equalTo(albumImage.snp.size).multipliedBy(0.92)
        }
        
        songName.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(albumImage.snp.bottom).offset(40)
        }
        
        artistName.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(songName.snp.bottom).offset(5)
        }
        
        playButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(artistName.snp.bottom).offset(100)
            $0.size.equalTo(60)
        }
        
        previousButton.snp.makeConstraints {
            $0.centerY.equalTo(playButton.snp.centerY)
            $0.trailing.equalTo(playButton.snp.leading).offset(-30)
            $0.size.equalTo(60)
        }
        
        nextButton.snp.makeConstraints {
            $0.centerY.equalTo(playButton.snp.centerY)
            $0.leading.equalTo(playButton.snp.trailing).offset(30)
            $0.size.equalTo(60)
        }
    }
    
    @objc
    private func playTapped() {
        isPlaying.toggle()
    }
    
    private func changeButtonStyle(imageName: String) {
        playButton.setImage(UIImage(systemName: imageName, withConfiguration: sc), for: .normal)
        playButton.tintColor = .black
    }
}

extension AppleMusicDetailViewController {
    func passDatas(image: UIImage, artist: String, song: String) {
        albumImage.image = image
        artistName.text = artist
        songName.text = song
    }
}

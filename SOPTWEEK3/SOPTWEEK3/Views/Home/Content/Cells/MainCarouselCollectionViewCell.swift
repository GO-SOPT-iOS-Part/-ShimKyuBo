//
//  MainCarouselCollectionViewCell.swift
//  SOPTWEEK3
//
//  Created by KYUBO A. SHIM on 2023/05/04.
//

import UIKit

import SnapKit
import Then

final class MainCarouselCollectionViewCell: UICollectionViewCell {
    
    private let mainImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        basicSetup()
        setStyle()
        setLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mainImageView.layer.sublayers?.forEach({
            $0.removeFromSuperlayer()
        })

        let width = self.bounds.width
        let height = self.bounds.height
        let gradientTopHeight: CGFloat = 200.0
        let gradientBottomHeight: CGFloat = 200.0
        let shadow = UIColor.black.cgColor
        let light = UIColor.clear.cgColor
 
        let topImageGradient = CAGradientLayer()
        topImageGradient.frame = CGRect(x: 0, y: 0, width: width, height: gradientTopHeight)
        topImageGradient.colors = [shadow, light]
        mainImageView.layer.insertSublayer(topImageGradient, at: 0)

        let bottomImageGradient = CAGradientLayer()
        bottomImageGradient.frame = CGRect(x: 0, y: height - gradientBottomHeight, width: width, height: gradientBottomHeight)
        bottomImageGradient.colors = [light, shadow]
        mainImageView.layer.insertSublayer(bottomImageGradient, at: 0)
    }
    
    private func basicSetup() {
        self.backgroundColor = .clear
    }
    
    private func setStyle() {
        mainImageView.do {
            $0.layer.masksToBounds = true
            $0.contentMode = .scaleAspectFill
            $0.backgroundColor = .systemGray6
            $0.insetsLayoutMarginsFromSafeArea = false
        }
    }
    
    private func setLayout() {
        self.addSubviews(mainImageView)
        
        mainImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainCarouselCollectionViewCell {
    func configureCell(imageName: String) {
        mainImageView.image = UIImage.load(name: imageName)
    }
}

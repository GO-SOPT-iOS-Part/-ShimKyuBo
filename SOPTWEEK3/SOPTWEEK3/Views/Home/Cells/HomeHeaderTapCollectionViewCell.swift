//
//  HomeHeaderTabCollectionViewCell.swift
//  SOPTWEEK3
//
//  Created by KYUBO A. SHIM on 2023/05/01.

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class HomeHeaderTapCollectionViewCell: UICollectionViewCell {
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                // 어떻게 앞에 있는 image 도 bold 하게 만들 수 있을까?
                tabMenuLabel.font = .CustomPretendarFont(.ExtraBold, forTextStyle: .body)
            } else {
                tabMenuLabel.font = .CustomPretendarFont(.Regular, forTextStyle: .body)
            }
        }
    }
    
    private let homeTabViewModel = HomeTapViewModel()
    
    private let imageBeforeText = UIImageView()
    private let tabMenuLabel = UILabel()
    
    private let stackView = UIStackView()
    
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
        imageBeforeText.do {
            $0.isHidden = true
            $0.contentMode = .scaleAspectFit
            $0.image = UIImage.load(name: "LiveLogo")
        }
        
        tabMenuLabel.do {
            $0.textColor = .white
            $0.font = .CustomPretendarFont(.Regular, forTextStyle: .body)
            $0.textAlignment = .center
            $0.adjustsFontSizeToFitWidth = true
        }
        
        stackView.do {
            $0.axis = .horizontal
            $0.distribution = .fill
            $0.spacing = 4
            $0.alignment = .center
        }
    }
    
    private func setLayout() {
        stackView.addArrangedSubview(imageBeforeText)
        stackView.addArrangedSubview(tabMenuLabel)
        self.addSubviews(stackView)
        
        stackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.equalTo(30)
            $0.leading.equalToSuperview().inset(15)
            $0.trailing.equalToSuperview().inset(5)
        }

        imageBeforeText.snp.makeConstraints {
            $0.height.equalTo(stackView.snp.height)
            $0.width.equalTo(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeHeaderTapCollectionViewCell {
    func configureCell(tabMenu: String) {
        self.tabMenuLabel.text = tabMenu
    }
    
    func configureCellWithImage(tabMenu : String) {
        self.tabMenuLabel.text = tabMenu
        self.imageBeforeText.isHidden = false
    }
    
    func fetchCellWidthSize() -> CGFloat {
        print(stackView.frame.width)
        return stackView.frame.width
    }
}

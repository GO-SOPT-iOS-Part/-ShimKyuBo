//
//  ContentHeaderView.swift
//  SOPTWEEK3
//
//  Created by KYUBO A. SHIM on 2023/05/02.
//

import UIKit

import SnapKit
import Then

final class ContentHeaderView: UICollectionReusableView {
    
    typealias ActionHandler = () -> Void
    
    private let headerViewLabel = UILabel()
    private let extendsToFullViewButton = UIButton(type: .system)
    
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
        headerViewLabel.do {
            $0.textColor = .white
            $0.font = .CustomPretendarFont(.SemiBold, forTextStyle: .callout)
        }
        
        extendsToFullViewButton.do {
            $0.addImageToRight(title: "전체보기", font: .Medium , fontSize: .footnote, systemImageName: "chevron.right", systemImageSize: 8)
            $0.tintColor = .BrandGray3
            $0.titleLabel?.textColor = .BrandGray3
        }
    }
    
    private func setLayout() {
        self.addSubviews(headerViewLabel, extendsToFullViewButton)
        
        headerViewLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        extendsToFullViewButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(10)
            $0.bottom.equalTo(headerViewLabel.snp.bottom)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ContentHeaderView {
    func setTitle(with title: String) {
        headerViewLabel.text = title
    }
    
    func setAction(sectionIndex sectionId: Int, of action: @escaping ActionHandler) {
        extendsToFullViewButton.addAction(action)
    }
    
    func disableUI() {
        headerViewLabel.isHidden = true
        extendsToFullViewButton.isHidden = true
    }
}

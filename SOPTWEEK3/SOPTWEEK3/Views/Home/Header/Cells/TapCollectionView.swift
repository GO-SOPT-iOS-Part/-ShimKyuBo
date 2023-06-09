//
//  TapCollectionView.swift
//  SOPTWEEK3
//
//  Created by KYUBO A. SHIM on 2023/05/02.
//

import UIKit

import SnapKit
import Then

final class TapCollectionView: UICollectionView {

    private let underlineView = UIView()

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        basicSetup()
        setStyle()
        setLayout()
    }
    
    private func basicSetup() {
        self.backgroundColor = .clear
        self.isScrollEnabled = true
        self.showsHorizontalScrollIndicator = false
    }

    private func setStyle() {
        underlineView.do {
            $0.backgroundColor = .white
        }
    }

    private func setLayout() {
        self.addSubview(underlineView)
        
        underlineView.snp.makeConstraints {
            $0.height.equalTo(3.5)
            $0.centerY.equalToSuperview().offset(20)
            $0.width.equalTo(14)
            $0.leading.equalToSuperview().inset(15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TapCollectionView {
    func moveUnderlineFor(at tappedRect: TapRect) {
        underlineView.snp.updateConstraints {
            $0.height.equalTo(3.5)
            $0.centerY.equalToSuperview().offset(20)
            $0.width.equalTo(tappedRect.width)
            $0.leading.equalTo(tappedRect.xPosition.x)
        }
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
}

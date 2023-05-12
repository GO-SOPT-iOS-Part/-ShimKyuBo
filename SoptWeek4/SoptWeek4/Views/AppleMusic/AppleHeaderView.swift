//
//  AppleHeaderView.swift
//  SoptWeek4
//
//  Created by KYUBO A. SHIM on 2023/05/11.
//

import UIKit

class AppleHeaderView: UICollectionReusableView {
    
    private let catalogLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        catalogLabel.do {
            $0.font = UIFont.systemFont(ofSize: 19, weight: .bold)
            $0.textColor = .black.withAlphaComponent(0.8)
        }
        
        self.addSubview(catalogLabel)
        
        catalogLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(13)
            $0.top.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AppleHeaderView {
    func configureHeader(catalogTitle: String) {
        catalogLabel.text = catalogTitle
    }
}

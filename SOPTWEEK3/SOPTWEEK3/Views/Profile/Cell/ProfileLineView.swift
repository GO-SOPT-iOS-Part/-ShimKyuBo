//
//  ProfileLineView.swift
//  SOPTWEEK3
//
//  Created by KYUBO A. SHIM on 2023/05/05.
//

import UIKit

final class ProfileLineView: UIView {

    private let lineView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        
        lineView.do {
            $0.backgroundColor = .BrandGray4
        }
        
        self.addSubview(lineView)
        
        lineView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(0.5)
            $0.horizontalEdges.equalToSuperview().inset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

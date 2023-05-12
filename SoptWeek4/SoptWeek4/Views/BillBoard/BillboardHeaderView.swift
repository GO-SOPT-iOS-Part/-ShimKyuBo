//
//  BillboardHeaderView.swift
//  SoptWeek4
//
//  Created by KYUBO A. SHIM on 2023/05/10.
//

import UIKit

class BillboardHeaderView: UIView {

    private let dateLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        dateLabel.do {
            $0.font = UIFont.systemFont(ofSize: 18, weight: .regular)
            $0.textColor = .gray
        }
        
        self.addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BillboardHeaderView {
    func addDate(date: String) {
        let newDate = date.replacingOccurrences(of: "-", with: ".")
        dateLabel.text = newDate
    }
}

//
//  IndicatorCollectionReusableView.swift
//  SOPTWEEK3
//
//  Created by KYUBO A. SHIM on 2023/05/04.
//

import UIKit

final class IndicatorCollectionReusableView: UICollectionReusableView {

    private var pageNumbers: Int = 0
    let pageIndicator: UIPageControl = UIPageControl()

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
        pageIndicator.do {
            $0.numberOfPages = pageNumbers
            $0.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }
    }
    
    private func setLayout() {
        self.addSubview(pageIndicator)
        
        pageIndicator.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(-35)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension IndicatorCollectionReusableView: PageIndicatorDelegate {
    func passPages(page: Int) {
        print("⭐️")
        pageIndicator.currentPage = page
    }
}

extension IndicatorCollectionReusableView {
    func configurePage(pageCounts: Int) {
        pageIndicator.numberOfPages = pageCounts
    }
    
    func diableUI() {
        pageIndicator.isHidden = true
    }
}

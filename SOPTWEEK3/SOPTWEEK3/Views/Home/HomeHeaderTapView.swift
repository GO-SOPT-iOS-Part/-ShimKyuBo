//
//  HomeHeaderTapView.swift
//  SOPTWEEK3
//
//  Created by KYUBO A. SHIM on 2023/05/01.
//

import UIKit

import SnapKit
import Then

final class HomeHeaderTapView: UIView {
    private lazy var tapList = HomeCommonViewModel.HeaderTaps.allCases
    
    private var isHomeSelected = true
    private var selectedTapIndex: Int = 0
    private var selectedTapRect: TapRect!
    
    private lazy var tapViewCollectionView = TapCollectionView(frame: .zero, collectionViewLayout: setFlowLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        basicSetup()
        setStyle()
        setLayout()
    }
    
    private func basicSetup() {
        self.backgroundColor = .clear
        tapViewCollectionView.delegate = self
        tapViewCollectionView.dataSource = self
    }
    
    private func setStyle() {
        tapViewCollectionView.do {
            $0.register(HomeHeaderTapCollectionViewCell.self, forCellWithReuseIdentifier: HomeHeaderTapCollectionViewCell.cellIdentifier)
        }
    }
    
    private func setLayout() {
        self.addSubviews(tapViewCollectionView)
        
        tapViewCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeHeaderTapView {
    private func setFlowLayout() -> UICollectionViewFlowLayout {
        let tapViewFlowLayout = UICollectionViewFlowLayout()
        tapViewFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        tapViewFlowLayout.scrollDirection = .horizontal
        tapViewFlowLayout.minimumLineSpacing = 5
        return tapViewFlowLayout
    }
}

extension HomeHeaderTapView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        isHomeSelected = false
        selectedTapIndex = indexPath.item
        
        let selectedTapRect: TapRect = collectionView.fetchCellRectFor(indexPath: indexPath, paddingFromLeading: 15, cellHorizontalPadding: 20)
        
        tapViewCollectionView.moveUnderlineFor(at: selectedTapRect)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tapList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeHeaderTapCollectionViewCell.cellIdentifier, for: indexPath) as? HomeHeaderTapCollectionViewCell else { return UICollectionViewCell() }
        
        if indexPath.item == 0 && isHomeSelected == true {
            cell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
        }
        
        if indexPath.item == 1 {
            cell.configureCellWithImage(tapMenu: tapList[indexPath.item].rawValue)
            return cell
        } else {
            cell.configureCell(tapMenu: tapList[indexPath.item].rawValue)
            return cell
        }
    }
}

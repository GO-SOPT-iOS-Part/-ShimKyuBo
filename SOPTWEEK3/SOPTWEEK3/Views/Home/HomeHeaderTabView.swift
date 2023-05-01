//
//  HomeHeaderTabView.swift
//  SOPTWEEK3
//
//  Created by KYUBO A. SHIM on 2023/05/01.
//

import UIKit

import SnapKit
import Then

final class HomeHeaderTabView: UIView {
    private lazy var tapList = HomeCommonViewModel.HeaderTabs.allCases
    
    private var isHomeSelected = true
    
    private lazy var tapViewCollectionView = UICollectionView(frame: .zero, collectionViewLayout: setFlowLayout())
    
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
            $0.register(HomeHeaderTabCollectionViewCell.self, forCellWithReuseIdentifier: HomeHeaderTabCollectionViewCell.cellIdentifier)
            $0.backgroundColor = .clear
            $0.isScrollEnabled = true
            $0.showsHorizontalScrollIndicator = false
        }
    }
    
    private func setLayout() {
        self.addSubview(tapViewCollectionView)
        
        tapViewCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeHeaderTabView {
    private func setFlowLayout() -> UICollectionViewFlowLayout {
        let tapViewFlowLayout = UICollectionViewFlowLayout()
        tapViewFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        tapViewFlowLayout.scrollDirection = .horizontal
        tapViewFlowLayout.minimumLineSpacing = 5
        return tapViewFlowLayout
    }
}

extension HomeHeaderTabView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        isHomeSelected = false

        print("\(indexPath.item)")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tapList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeHeaderTabCollectionViewCell.cellIdentifier, for: indexPath) as? HomeHeaderTabCollectionViewCell else { return UICollectionViewCell() }
        
        if indexPath.item == 0 && isHomeSelected == true {
            cell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
        }
        
        if indexPath.item == 1 {
            cell.configureCellWithImage(tabMenu: tapList[indexPath.item].rawValue)
            return cell
        } else {
            cell.configureCell(tabMenu: tapList[indexPath.item].rawValue)
            return cell
        }
    }
}

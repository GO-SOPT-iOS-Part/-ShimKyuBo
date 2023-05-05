//
//  HomeMainCarouselView.swift
//  SOPTWEEK3
//
//  Created by KYUBO A. SHIM on 2023/05/04.
//

import UIKit

import SnapKit
import Then

final class HomeMainCarouselView: UIView {
    
    private let homeTapViewModel = HomeTapViewModel()
    private lazy var mainPostersForCarousel = homeTapViewModel.fetchMainPostersForCarousel().value
    private lazy var dataCount = mainPostersForCarousel.count
    
    lazy var mainCarouselCollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.setFlowLayout())
    private let pageIndicator: UIPageControl = UIPageControl()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        basicSetup()
        setStyle()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print(mainPostersForCarousel)
    }
    
    private func basicSetup() {
        self.backgroundColor = .clear
        mainCarouselCollectionView.dataSource = self
        mainCarouselCollectionView.delegate = self
    }
    
    private func setStyle() {
        mainCarouselCollectionView.do {
            $0.isScrollEnabled = true
            $0.backgroundColor = .clear
            $0.register(MainCarouselCollectionViewCell.self, forCellWithReuseIdentifier: MainCarouselCollectionViewCell.cellIdentifier)
            $0.showsHorizontalScrollIndicator = false
            $0.isPagingEnabled = true
        }
        
        pageIndicator.do {
            $0.numberOfPages = mainPostersForCarousel.count
            $0.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        }
    }
    
    private func setLayout() {
        self.addSubviews(mainCarouselCollectionView, pageIndicator)
        
        mainCarouselCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        pageIndicator.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(-40)
            $0.bottom.equalToSuperview().offset(10)
        }
    }
}

extension HomeMainCarouselView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCarouselCollectionViewCell.cellIdentifier, for: indexPath) as? MainCarouselCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configureCell(imageName: mainPostersForCarousel[(indexPath.item + 1) % dataCount] ?? "defaultImage")
        
        return cell
    }
    
    private func setFlowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        let width: CGFloat = 393
        let height = width / 0.68
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: width, height: height)
        return flowLayout
    }
}

extension HomeMainCarouselView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.frame.size.width != 0 {
            let page = Int(
                round(scrollView.contentOffset.x / UIScreen.main.bounds.width)) % dataCount
            pageIndicator.currentPage = page
        }
    }
    
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        let endOffset = scrollView.con
//    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page: Int = Int(round(scrollView.contentOffset.x / UIScreen.main.bounds.width))
        
        switch page {
        case 0:
            let last = dataCount - 2
            mainCarouselCollectionView.scrollToItem(at: [0, last], at: .left, animated: false)
        case dataCount - 1:
            mainCarouselCollectionView.scrollToItem(at: [0, 1], at: .right, animated: false)
        default:
            break
        }
    }
}

/*
 
 extension HomeMainCarouselView: UICollectionViewDataSource {
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return self.dataCount
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCarouselCollectionViewCell.cellIdentifier, for: indexPath) as? MainCarouselCollectionViewCell else { return UICollectionViewCell() }
         
         cell.configureCell(imageName: mainPostersForCarousel[(indexPath.item + 1) % dataCount] ?? "defaultImage")
         
         return cell
     }
     
     private func setFlowLayout() -> UICollectionViewFlowLayout {
         let flowLayout = UICollectionViewFlowLayout()
         let width = UIScreen.main.bounds.width
         let height = width / 0.68
         flowLayout.minimumLineSpacing = 0
         flowLayout.minimumInteritemSpacing = 0
         flowLayout.scrollDirection = .horizontal
         flowLayout.itemSize = CGSize(width: width, height: height)
         return flowLayout
     }
 }

 extension HomeMainCarouselView: UIScrollViewDelegate {
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
         let page = Int(
             (mainCarouselCollectionView.contentOffset.x / mainCarouselCollectionView.frame.width).rounded(.toNearestOrAwayFromZero)) % dataCount
         
         if mainCarouselCollectionView.contentOffset.x > mainCarouselCollectionView.frame.width * CGFloat(dataCount) {
             mainCarouselCollectionView.scrollToItem(at: [0, 0], at: .left, animated: false)
         } else if mainCarouselCollectionView.contentOffset.x < 0 {
             mainCarouselCollectionView.scrollToItem(at: [0, dataCount], at: .left, animated: false)
         }
         
         pageIndicator.currentPage = page
     }
 }
 
 
 */

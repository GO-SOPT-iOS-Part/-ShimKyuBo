//
//  HomeContentView.swift
//  SOPTWEEK3
//
//  Created by KYUBO A. SHIM on 2023/05/02.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

    // 주는 쪽
final class HomeContentView: UIView {
            
    private let homeTapViewModel = HomeTapViewModel()
    private let sectionCases = HomeTapViewModel.Sections.allCases
    
    private lazy var bestShowsData = homeTapViewModel.fetchBestShowsPosters().value
    private lazy var topMoviesData = homeTapViewModel.fetchTopTwentyMoviesPosters().value
    private lazy var liveChannelsData = homeTapViewModel.fetchLiveShows().value
    private lazy var bannerShowsData = homeTapViewModel.fetchBannerPosters().value
    private lazy var paramountsData = homeTapViewModel.fetchParamountPosters().value
    private lazy var exclusiveShowsData = homeTapViewModel.fetchTvingExclusivePosters().value
        
    private let bestShowsTitles = ["너의 이름은", "시그널", "해리포터 시리즈", "반지의 제왕", "스즈메의 문단속"]
    private let paramountTitles = ["그리스 라이즈 오브 핑크 레이디스", "엘로우 재킷", "레빗홀", "메이어 오브 킹스타운", "해리슨 포드"]
    private let liveTitles = ["2023 KBO 리그3", "JTBC", "2023 KNO 리그2", "tvN Show"]
    
    private lazy var topMovieTitles = bestShowsTitles
    
    private lazy var mainPostersForCarousel = homeTapViewModel.fetchMainPostersForCarousel().value
    private lazy var dataCount = mainPostersForCarousel.count
    
    private lazy var contentCollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.setCompositionLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        basicSetup()
        setStyle()
        setLayout()
    }
    
    private func basicSetup() {
        self.backgroundColor = .clear
        
        contentCollectionView.dataSource = self
        contentCollectionView.delegate = self
    }
    
    private func setStyle() {
        contentCollectionView.do {
            $0.showsVerticalScrollIndicator = true
            $0.showsHorizontalScrollIndicator = false
            $0.isScrollEnabled = true
            $0.backgroundColor = .clear
            $0.clipsToBounds = true
            
            $0.register(ContentPosterCollectionViewCell.self, forCellWithReuseIdentifier: ContentPosterCollectionViewCell.cellIdentifier)
            $0.register(ContentLiveCollectionViewCell.self, forCellWithReuseIdentifier: ContentLiveCollectionViewCell.cellIdentifier)
            $0.register(ContentBannerCollectionViewCell.self, forCellWithReuseIdentifier: ContentBannerCollectionViewCell.cellIdentifier)
            $0.register(MainCarouselCollectionViewCell.self, forCellWithReuseIdentifier: MainCarouselCollectionViewCell.cellIdentifier)
            
            $0.register(ContentHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
            $0.register(IndicatorCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "FooterView")
        }
    }
    
    private func setLayout() {
        self.addSubview(contentCollectionView)
        
        contentCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeContentView {
    private func setCompositionLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { (section, _) -> NSCollectionLayoutSection? in
            switch section {
            case 0:
                let itemFractionalWidthFraction: CGFloat = 1.0 / 1.0
                let groupFractionalHeightFraction: CGFloat = 1.0 / 1.6
                let itemInset: CGFloat = 0
                
                let section = self.getNSCollectionLayoutSection(fractionalWidth: itemFractionalWidthFraction, fractionalHeight: groupFractionalHeightFraction, itemInset: itemInset, leadingInset: 0, bottomInset: 20, absoluteHeaderHeightOf: 0, absoluteFooterSizeOf: 20, orthogonalBehavior: .paging)
                
                return section
            case 1, 2, 5:
                let itemFractionalWidthFraction: CGFloat = 1.0 / 3.2
                let groupFractionalHeightFraction: CGFloat = 1.0 / 4.8
                let itemInset: CGFloat = 7
                
                let section = self.getNSCollectionLayoutSection(fractionalWidth: itemFractionalWidthFraction, fractionalHeight: groupFractionalHeightFraction, itemInset: itemInset, bottomInset: 13, absoluteHeaderHeightOf: 20)
                
                return section
            case 3:
                let itemFractionalWidthFraction: CGFloat = 1.0 / 2.2
                let groupFractionalHeightFraction: CGFloat = 1.0 / 7.0
                let itemInset: CGFloat = 7
                
                let section = self.getNSCollectionLayoutSection(fractionalWidth: itemFractionalWidthFraction, fractionalHeight: groupFractionalHeightFraction, itemInset: itemInset, absoluteHeaderHeightOf: 20)
                
                return section
            case 4:
                let itemFractionalWidthFraction: CGFloat = 1.0 / 1.2
                let groupFractionalHeightFraction: CGFloat = 1.0 / 7.8
                let itemInset: CGFloat = 7
                
                let section = self.getNSCollectionLayoutSection(fractionalWidth: itemFractionalWidthFraction, fractionalHeight: groupFractionalHeightFraction, itemInset: itemInset, topInset: 10, bottomInset: 10, absoluteHeaderHeightOf: 20)
                
                return section
            case 6:
                let itemFractionalWidthFraction: CGFloat = 1.0 / 2.3
                let groupFractionalHeightFraction: CGFloat = 1.0 / 3.3
                let itemInset: CGFloat = 7
                
                let section = self.getNSCollectionLayoutSection(fractionalWidth: itemFractionalWidthFraction, fractionalHeight: groupFractionalHeightFraction, itemInset: itemInset, absoluteHeaderHeightOf: 20)
                
                return section
            default:
                let itemFractionalWidthFraction = 1.0 / 5.0
                let groupFractionalHeightFraction = 1.0 / 4.0
                let itemInset: CGFloat = 2.5

                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(itemFractionalWidthFraction),
                    heightDimension: .fractionalHeight(1)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(groupFractionalHeightFraction)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
                return section
            }
        }
    }
    
    private func getNSCollectionLayoutSection(fractionalWidth: CGFloat, fractionalHeight: CGFloat, itemInset: CGFloat, leadingInset: CGFloat = 15, topInset: CGFloat = 4, bottomInset: CGFloat = 0, absoluteHeaderHeightOf absoluteSize: CGFloat, absoluteFooterSizeOf absoluteFooterSize: CGFloat = 0, orthogonalBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior = .continuous) -> NSCollectionLayoutSection {
            
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: 0, bottom: itemInset, trailing: itemInset)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fractionalWidth), heightDimension: .fractionalHeight(fractionalHeight))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: topInset, leading: leadingInset, bottom: bottomInset, trailing: 0)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(absoluteSize))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(absoluteFooterSize))
        let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
        footer.contentInsets = NSDirectionalEdgeInsets(top: -25, leading: -10, bottom: 0, trailing: 0)
        
        section.boundarySupplementaryItems = [header, footer]
        section.orthogonalScrollingBehavior = orthogonalBehavior
        
        return section
    }
}

extension HomeContentView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.sectionCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return dataCount
        case 1:
            return bestShowsData.count
        case 2:
            return topMoviesData.count
        case 3:
            return liveChannelsData.count
        case 4:
            return bannerShowsData.count
        case 5:
            return paramountsData.count
        case 6:
            return exclusiveShowsData.count
        default:
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCarouselCollectionViewCell.cellIdentifier, for: indexPath) as? MainCarouselCollectionViewCell else { return UICollectionViewCell() }
            cell.configureCell(imageName: mainPostersForCarousel[indexPath.item] ?? "defaultImage")
            
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentPosterCollectionViewCell.cellIdentifier, for: indexPath) as? ContentPosterCollectionViewCell else { return UICollectionViewCell() }
            cell.configureCell(imageName: bestShowsData[indexPath.item] ?? "defaultImage", posterTitle: bestShowsTitles[indexPath.item])
            
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentPosterCollectionViewCell.cellIdentifier, for: indexPath) as? ContentPosterCollectionViewCell else { return UICollectionViewCell() }
            cell.configureCell(imageName: topMoviesData[indexPath.item] ?? "defaultImage", posterTitle: topMovieTitles[indexPath.item])
            
            return cell
        case 3:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentLiveCollectionViewCell.cellIdentifier, for: indexPath) as? ContentLiveCollectionViewCell else { return UICollectionViewCell() }
            cell.configureCell(imageName: liveChannelsData[indexPath.item] ?? "defaultImage", posterTitle: liveTitles[indexPath.item], rank: indexPath.item + 1)
            
            return cell
        case 4:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentBannerCollectionViewCell.cellIdentifier, for: indexPath) as? ContentBannerCollectionViewCell else { return UICollectionViewCell() }
            cell.configureCell(imageName: bannerShowsData[indexPath.item] ?? "defaultImage")
            
            return cell
        case 5:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentPosterCollectionViewCell.cellIdentifier, for: indexPath) as? ContentPosterCollectionViewCell else { return UICollectionViewCell() }
            cell.configureCell(imageName: paramountsData[indexPath.item] ?? "defaultImage", posterTitle: paramountTitles[indexPath.item])
            
            return cell
        case 6:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentPosterCollectionViewCell.cellIdentifier, for: indexPath) as? ContentPosterCollectionViewCell else { return UICollectionViewCell() }
            cell.configureCell(imageName: exclusiveShowsData[indexPath.item] ?? "defaultImage", posterTitle: "")
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as? ContentHeaderView else { return UICollectionReusableView() }
            switch indexPath.section {
            case 0:
                header.disableUI()

                return header
            case 1:
                header.setTitle(with: sectionCases[indexPath.section].rawValue)
                
                return header
            case 2:
                header.setTitle(with: sectionCases[indexPath.section].rawValue)
                
                return header
            case 3:
                header.setTitle(with: "asdfasdfa")
                
                return header
            case 4:
                header.disableUI()

                return header
            case 5:
                header.setTitle(with: sectionCases[indexPath.section].rawValue)
                
                return header
            case 6:
                header.setTitle(with: sectionCases[indexPath.section].rawValue)
                
                return header
            default:
                return UICollectionReusableView()
            }
        case UICollectionView.elementKindSectionFooter:
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FooterView", for: indexPath) as? IndicatorCollectionReusableView else { return UICollectionReusableView() }
            
            switch indexPath.section {
            case 0:
                footer.configurePage(pageCounts: dataCount)
                return footer
            default :
                footer.diableUI()
                return footer
            }
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
        }
    }
}

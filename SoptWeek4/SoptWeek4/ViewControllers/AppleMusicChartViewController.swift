//
//  AppleMusicChartViewController.swift
//  SoptWeek4
//
//  Created by KYUBO A. SHIM on 2023/05/09.
//

import MusicKit
import UIKit

import Alamofire
import SnapKit
import Then

final class AppleMusicChartViewController: UIViewController {
    
    private let cache = ImageCacheManager.shared
    private let appleMusicManager = AppleMusicManager.shared
    private var appleMusicCatalogCharts: [AppleSongsItem] = []
    
    private lazy var catalogCollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.setFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfiguration()
        setStyle()
        setLayout()
        getCatalogChartsWhenLoaded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationItem.title = "둘러보기"
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle.badge.moon"), style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem?.tintColor = .systemOrange
    }
    
    private func setConfiguration() {
        view.backgroundColor = .white
        
        catalogCollectionView.delegate = self
        catalogCollectionView.dataSource = self
    }
    
    private func setStyle() {
        catalogCollectionView.do {
            $0.register(AppleMusicSongCollectionViewCell.self, forCellWithReuseIdentifier: "appleMusic")
            $0.register(AppleHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
            $0.backgroundColor = .clear
            $0.isScrollEnabled = true
            $0.contentInset = UIEdgeInsets(top: 4, left: 5, bottom: 4, right: 5)
        }
    }
    
    private func setLayout() {
        view.addSubview(catalogCollectionView)
        
        catalogCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func getCatalogChartsWhenLoaded() {
        Task {
            async let array = await appleMusicManager.getAppleChart()
            self.appleMusicCatalogCharts = await array
            self.catalogCollectionView.reloadData()
        }
    }

    private func setFlowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width/3.2, height: 170)
        flowLayout.scrollDirection = .vertical
        
        return flowLayout
    }
}

extension AppleMusicChartViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appleMusicCatalogCharts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "appleMusic", for: indexPath) as? AppleMusicSongCollectionViewCell else { return UICollectionViewCell() }
        let musicItem = appleMusicCatalogCharts[indexPath.item]
        
        let songTitle = musicItem.songTitle
        let artist = musicItem.artistName
        var albumImage = UIImage()
        
        guard let albumImageUrl = musicItem.imageUrl else { return UICollectionViewCell()}
        let highQualitUrlString = albumImageUrl.absoluteString + "Q"
        let thumbnailCacheKey = NSString(string: albumImageUrl.absoluteString)
        let highQImageCacheKey = NSString(string: highQualitUrlString)
                
        Task {
            albumImage = try await UIImage.load(url: albumImageUrl)
            
            if let cachedImage = self.cache.object(forKey: thumbnailCacheKey) {
                cell.cofigureCell(albumImage: cachedImage, song: songTitle, artist: artist)
            } else {
                guard let thumbnailImage = albumImage.preparingThumbnail(of: CGSize(width: 200, height: 200)) else { return }
                guard let highQImage = albumImage.preparingThumbnail(of: CGSize(width: 700, height: 700)) else { return }
                
                self.cache.setObject(thumbnailImage, forKey: thumbnailCacheKey)
                self.cache.setObject(highQImage, forKey: highQImageCacheKey)
                
                cell.cofigureCell(albumImage: thumbnailImage, song: songTitle, artist: artist)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as? AppleHeaderView else { return UICollectionReusableView() }
            headerView.configureHeader(catalogTitle: "Top Songs40: 대한민국")
            return headerView
        default:
            assert(false, "Nope")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let musicItem = appleMusicCatalogCharts[indexPath.item]
        
        let songTitle = musicItem.songTitle
        let artist = musicItem.artistName
        var albumImage = UIImage()
        
        guard let albumImageUrl = musicItem.imageUrl else { return }
        let highQualitUrlString = albumImageUrl.absoluteString + "Q"
        let highQImageCacheKey = NSString(string: highQualitUrlString)
        
        let detailVC = AppleMusicDetailViewController()
        guard let cachedAlbumImage = self.cache.object(forKey: highQImageCacheKey) else { return }
        detailVC.passDatas(image: cachedAlbumImage, artist: artist, song: songTitle)
        detailVC.modalPresentationStyle = .formSheet
        detailVC.sheetPresentationController?.prefersGrabberVisible = true
        
        self.navigationController?.present(detailVC, animated: true)
    }
}

extension AppleMusicChartViewController {
    func passList(chart: [AppleSongsItem]) {
        self.appleMusicCatalogCharts = chart
        print("⭐️⭐️📍⭐️⭐️")
    }
}

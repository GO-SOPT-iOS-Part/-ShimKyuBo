//
//  ViewController.swift
//  SoptWeek4
//
//  Created by KYUBO A. SHIM on 2023/05/06.
//

import MusicKit
import UIKit

import Alamofire
import SnapKit
import Then

final class BillBoardChartViewController: UIViewController {
    
    typealias ChartData = BillBoardModel.ChartModel
    
    private let cache = ImageCacheManager.shared
    private let billboardManager = BillBoardManager.shared
    private var billboardChart: [ChartData] = []
    private lazy var chartDateLabel = BillboardHeaderView()
    
    private lazy var billboardTableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfiguration()
        setStyle()
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationItem.title = "Billboard Chart 100"
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil.circle"), style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem?.tintColor = .systemOrange
        
        self.getChart { chartItems, chartDate in
            self.billboardChart = chartItems
            self.chartDateLabel.addDate(date: chartDate)
            self.billboardTableView.reloadData()
        }
    }
    
    private func setConfiguration() {
        view.backgroundColor = .black
        
        billboardTableView.dataSource = self
        billboardTableView.delegate = self
    }
    
    private func setStyle() {
        billboardTableView.do {
            $0.register(BillBoardTableViewCell.self, forCellReuseIdentifier: "BillBoard")
            $0.rowHeight = 60
        }
    }
    
    private func setLayout() {
        view.addSubview(billboardTableView)
        
        billboardTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }

    private func getChart(completion: @escaping (([ChartData], String) -> Void)) {
        var chartArray: [ChartData] = []
        
        billboardManager.requestChart(withTypeOf: BillBoardModel.self) { response in
            switch response {
            case .success(let data):
                let chartDate = data.date
                let chartItem = data.data
                chartArray.append(contentsOf: chartItem)
                
                completion(chartArray, chartDate)
            default:
                print("Error happended and Returning the last Array of Chart.")
                completion(chartArray, "2023")
            }
        }
    }
}

extension BillBoardChartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return billboardChart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BillBoard", for: indexPath) as? BillBoardTableViewCell else { return UITableViewCell() }
        let billboardItem = billboardChart[indexPath.row]
        let rank = billboardItem.rank
        let artist = billboardItem.artist
        let song = billboardItem.songName
        
        let thumbnailImageUrlString = billboardItem.albumImage
        let highQImageCacheKey = NSString(string: thumbnailImageUrlString + "Q")
        let imageCacheKey = NSString(string: thumbnailImageUrlString)
        
        if let cachedImage = self.cache.object(forKey: imageCacheKey) {
            cell.configureCell(image: cachedImage, rank: rank, artistName: artist, songName: song)
        } else {
            AF.request(thumbnailImageUrlString, method: .get).response { response in
                guard let imageData = response.value else { return }
                guard let thumbnailImage = UIImage(data: imageData ?? Data())?.preparingThumbnail(of: CGSize(width: 100, height: 100)) else { return }
                guard let highQImage = UIImage(data: imageData ?? Data())?.preparingThumbnail(of: CGSize(width: 700, height: 700)) else { return }
                
                self.cache.setObject(thumbnailImage, forKey: imageCacheKey)
                self.cache.setObject(highQImage, forKey: highQImageCacheKey)

                cell.configureCell(image: thumbnailImage, rank: rank, artistName: artist, songName: song)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return chartDateLabel
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let billboardItem = billboardChart[indexPath.row]
        let thumbnailImageUrlString = billboardItem.albumImage
        let highQImageCacheKey = NSString(string: thumbnailImageUrlString + "Q")
        let imageCacheKey = NSString(string: thumbnailImageUrlString)
        
        let artist = billboardItem.artist
        let song = billboardItem.songName
        
        let detailVC = BillBoardDetailViewController()
        guard let cachedAlbumImage = self.cache.object(forKey: highQImageCacheKey) else {
            return }
        detailVC.passDatas(image: cachedAlbumImage, artist: artist, song: song)
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}


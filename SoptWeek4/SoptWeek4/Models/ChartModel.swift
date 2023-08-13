//
//  ChartModel.swift
//  SoptWeek4
//
//  Created by KYUBO A. SHIM on 2023/05/09.
//

import Foundation
import MusicKit

struct BillBoardModel: Codable {
    typealias ChartModel = BillBoardCharts

    var date: String
    var data: [ChartModel]
}

struct BillBoardCharts: Codable {
    let songName, artist: String
    let albumImage: String
    let rank: Int
    let lastWeekRank: Int?
    let peakRank, weeksOnChart: Int
    
    enum CodingKeys: String, CodingKey {
        case artist, rank
        case songName = "name"
        case albumImage = "image"
        case lastWeekRank = "last_week_rank"
        case peakRank = "peak_rank"
        case weeksOnChart = "weeks_on_chart"
    }
}

struct AppleSongsItem: Identifiable, Hashable {
    var id = UUID()
    let songTitle: String
    let artistName: String
    let imageUrl: URL?
}


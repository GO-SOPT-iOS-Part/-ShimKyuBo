//
//  AppleMusicManager.swift
//  SoptWeek4
//
//  Created by KYUBO A. SHIM on 2023/05/09.
//

import Foundation
import MusicKit

final class AppleMusicManager {
    
    static let shared = AppleMusicManager()
    
    private init() {}
    
    private let requestLimit: Int = 40
    
    private lazy var request: MusicCatalogChartsRequest = {
        var request = MusicCatalogChartsRequest(types: [Song.self])
        request.limit = requestLimit
        
        return request
    }()
    
    func getAppleChart() async -> [AppleSongsItem] {
        let status = await MusicAuthorization.request()
        
        switch status {
        case .authorized:
            do {
                let response = try await request.response()
                
                guard let songsArray = response.songCharts.first?.items else { return [] }
                
                let result = songsArray.map {
                    AppleSongsItem(songTitle: $0.title, artistName: $0.artistName, imageUrl: $0.artwork?.url(width: 200, height: 200))
                }
                
                return result
            } catch {
                print(String(describing: error))
            }
        default:
            print("Not Authorized.")
            break
        }
        
        return []
    }
}

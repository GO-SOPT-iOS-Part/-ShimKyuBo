//
//  Protocols.swift
//  SoptWeek4
//
//  Created by KYUBO A. SHIM on 2023/05/09.
//

import Foundation

protocol MusicData {
    associatedtype ChartModel
    
    var date: String { get set }
    var data: ChartModel { get set }
}

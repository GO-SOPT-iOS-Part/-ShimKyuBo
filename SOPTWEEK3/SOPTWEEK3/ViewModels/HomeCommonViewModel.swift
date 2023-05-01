//
//  HomeCommonViewModel.swift
//  SOPTWEEK3
//
//  Created by KYUBO A. SHIM on 2023/05/01.
//

import UIKit

import RxSwift
import RxCocoa

final class HomeCommonViewModel {
    // 그 버튼 누르면 넘어가는거 전부 여기에 넣어
    
    enum HeaderTabs: String, CaseIterable {
        case home = "홈"
        case live = "실시간"
        case tvSeries = "TV프로그램"
        case movies = "영화"
        case paramount = "파라마운트+"
        case kids = "키즈"
    }
}

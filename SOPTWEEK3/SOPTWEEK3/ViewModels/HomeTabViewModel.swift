//
//  HomeViewModel.swift
//  SOPTWEEK3
//
//  Created by KYUBO A. SHIM on 2023/05/01.
//

import UIKit

import RxSwift
import RxCocoa

final class HomeTabViewModel: ViewModelType {
    typealias ImageName = String
    
    struct Dependency {
        
    }
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    let dependency: Dependency
    var disposeBag: DisposeBag = DisposeBag()
    let input: Input
    let output: Output
    
    enum HeaderTabs {
        case home
        case live
        case tvSeries
        case movies
        case paramount
        case kids
        
        var tabMenu: String {
            switch self {
            case .home:
                return "홈"
            case .live:
                return "실시간"
            case .tvSeries:
                return "TV프로그램"
            case .movies:
                return "영화"
            case .paramount:
                return "파라마운트+"
            case .kids:
                return "키즈"
            }
        }
    }
    
    enum Sections {
        case
    }
    
    
    
}

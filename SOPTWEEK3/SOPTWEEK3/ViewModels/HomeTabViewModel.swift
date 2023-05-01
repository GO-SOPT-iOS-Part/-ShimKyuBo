//
//  HomeViewModel.swift
//  SOPTWEEK3
//
//  Created by KYUBO A. SHIM on 2023/05/01.
//

import UIKit

import RxSwift
import RxCocoa

final class HomeTabViewModel: HomeTabsType {
    
    typealias PosterImageName = String
    typealias SectionName = String

    var disposeBag: DisposeBag = DisposeBag()
    let tabIdentity: String = HomeCommonViewModel.HeaderTabs.home.rawValue
    private let postersArray: [PosterImageName?] = ["KiminoPoster", "SiganlPoster", "HPPoster", "LOTRPoster", "SuzumePoster"]
    private let bannersArray: [PosterImageName?] = ["banner1", "banner2", "banner3"]
    private let paramountArray: [PosterImageName?] = ["para1", "para2", "para3", "para4", "para5"]
    private let tvingExclusiveArray: [PosterImageName?] = ["tvEx1", "tvEx2", "tvEx3", "tvEx4"]
    
    private let mainPosters: BehaviorRelay<[PosterImageName?]>
    private let bestShowsPosters: BehaviorRelay<[PosterImageName?]>
    private let topTwentyMovies: BehaviorRelay<[PosterImageName?]>
    
    // 화면에 나오지 않은 부분은 lazy 로 처리해서 처음 화면이 뜰 때 최대한 성능이 좋게 하려는데 이런 플로우가 맞는지 헷갈리네.. 이게 맞는 방법일까?
    private lazy var bannerPosters: BehaviorRelay<[PosterImageName?]> = BehaviorRelay(value: [])
    private lazy var paramountPosters: BehaviorRelay<[PosterImageName?]> = BehaviorRelay(value: [])
    private lazy var tvingExclusivePosters: BehaviorRelay<[PosterImageName?]> = BehaviorRelay(value: [])
    
    enum Sections: SectionName, CaseIterable {
        case bestShows = "티빙에서 꼭 봐야하는 콘텐츠"
        case topMovies = "티빙 TOP 20 영화"
        case paramountExclusive = "파라마운트+의 따끈한 신작"
        case tvingExclusive = "오직 티빙에만 있어요"
    }
    
    init() {
        let initialMainPosters: BehaviorRelay<[PosterImageName?]> = BehaviorRelay(value: postersArray)
        let initialBestShowsPosters: BehaviorRelay<[PosterImageName?]> = BehaviorRelay(value: postersArray.shuffled())
        let initialTopTwentyMovies: BehaviorRelay<[PosterImageName?]> = BehaviorRelay(value: postersArray.shuffled())
        
        self.mainPosters = initialMainPosters
        self.bestShowsPosters = initialBestShowsPosters
        self.topTwentyMovies = initialTopTwentyMovies
    }
}

extension HomeTabViewModel {
    func fetchBannerPosters() -> BehaviorRelay<[PosterImageName?]> {
        bannerPosters.accept(bannersArray)
        return bannerPosters
    }
    
    func fetchParamountPosters() -> BehaviorRelay<[PosterImageName?]> {
        paramountPosters.accept(paramountArray)
        return paramountPosters
    }
    
    func fetchTvingExclusivePosters() -> BehaviorRelay<[PosterImageName?]> {
        tvingExclusivePosters.accept(tvingExclusiveArray)
        return tvingExclusivePosters
    }
}

//
//  ProfileViewModel.swift
//  SOPTWEEK3
//
//  Created by KYUBO A. SHIM on 2023/05/01.
//

import UIKit

import RxSwift
import RxCocoa

final class ProfileViewModel {
    
    typealias TvingCash = Int
    typealias ProfileMenuName = String
    typealias isSubscribed = Bool
    
    private var user: ProfileModel = ProfileModel(userProfileImage: UIImage.load(name: "BearsLogo"))
    private lazy var userCash: TvingCash = getRandomCash()
    
    enum ProfileUpperMenus: ProfileMenuName, CaseIterable {
        case subscription = "이용권"
        case inquiryHistory = "1:1 문의내역"
        case reservedAlarm = "예약알림"
        case modifyingMyInfo = "회원정보 수정"
        case permissionOfPromotion = "프로모션 정보 수신 동의"
    }
    
    enum ProfileLowerMenus: ProfileMenuName, CaseIterable {
        case notice = "공지사항"
        case events = "이벤트"
        case customerService = "고객센터"
        case moreAboutTving = "티빙 알아보기"
    }
    
    init(userName: String) {
        if userName.contains("@") {
            self.user.userName =  userName.fetchOnlyIdFromEmail()
        } else {
            self.user.userName = userName
        }
    }
}

extension ProfileViewModel {
    func fetchUserInformation() -> ProfileModel {
        return user
    }
    
    func checkSubscription() -> isSubscribed {
        return false
    }
    
    func fetchTvingCash() -> TvingCash {
        return self.userCash
    }
    
    func fetchUpperProfileMenus() -> [ProfileMenuName] {
        var upperMenus: [ProfileMenuName] = []
        ProfileUpperMenus.allCases.forEach {
            upperMenus.append($0.rawValue)
        }
        
        return upperMenus
    }
    
    func fetchLowerProfileMenus() -> [ProfileMenuName] {
        var lowerMenus: [ProfileMenuName] = []
        ProfileLowerMenus.allCases.forEach {
            lowerMenus.append($0.rawValue)
        }
        
        return lowerMenus
    }
}

extension ProfileViewModel {
    private func getRandomCash() -> TvingCash {
        let numberBoundary: [Int] = Array(10...99)
        if let selectedNumber = numberBoundary.randomElement() {
            return selectedNumber * 1000
        }
        
        return 0
    }
}

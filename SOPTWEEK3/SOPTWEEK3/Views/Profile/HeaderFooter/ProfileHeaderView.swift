//
//  ProfileHeaderView.swift
//  SOPTWEEK3
//
//  Created by KYUBO A. SHIM on 2023/05/05.
//

import UIKit

import SnapKit
import Then

class ProfileHeaderView: UIView {
    static let headerViewID = "ProfileHeaderView"
    
    private let userImage = UIImageView()
    private let userName = UILabel()
    private let profileModifyButton = UIButton(type: .system)
    
    private let mySubscription = UILabel()
    private let currentSubscription = UILabel()
    
    private let tvingCashLabel = UILabel()
    private let myCash = UILabel()
    
    private let subscriptionGuideLabel = UILabel()
    private let guideBoxChevronImageView = UIImageView()
    
    private let profileTopStack = UIStackView()
    
    private let profileSubscriptionStack = UIStackView()
    private let profileCashStack = UIStackView()
    private let profileMyInfoStack = UIStackView()
    
    private let subscriptionGuideBox = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        basicSetup()
        setStyle()
        setLayout()
    }

    private func basicSetup() {
        self.backgroundColor = .clear
    }
    
    private func setStyle() {
        profileTopStack.do {
            $0.axis = .horizontal
            $0.spacing = 22
            $0.alignment = .center
        }
        
        profileModifyButton.do {
            $0.setTitle("프로필 전환", for: .normal)
            $0.titleLabel?.font = .CustomPretendarFont(.Medium, forTextStyle: .caption2)
            $0.setTitleColor(.BrandGray1, for: .normal)
            $0.layer.borderWidth = 0.5
            $0.layer.borderColor = UIColor.BrandGray1.cgColor
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 3
        }
        
        profileSubscriptionStack.do {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.distribution = .fillProportionally
        }
        
        profileCashStack.do {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.distribution = .fillProportionally
        }
        
        profileMyInfoStack.do {
            $0.axis = .vertical
            $0.spacing = 20
            $0.backgroundColor = .BrandGray4
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 4
        }
        
        subscriptionGuideBox.do {
            $0.axis = .horizontal
            $0.distribution = .fill
            $0.alignment = .center
            $0.backgroundColor = .BrandGray4
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 4
        }
        
        userImage.do {
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 15
            $0.contentMode = .scaleAspectFill
            $0.image = UIImage.load(name: "para5")
        }
        
        userName.do {
            $0.font = .CustomPretendarFont(.SemiBold, forTextStyle: .headline)
            $0.textColor = .white
            $0.numberOfLines = 1
        }
        
        mySubscription.do {
            $0.font = .CustomPretendarFont(.Medium, forTextStyle: .callout)
            $0.textColor = .BrandGray3
            $0.addImageBeforeText(imageName: "subscriptionLogo", text: " 나의 이용권")
        }
        
        currentSubscription.do {
            $0.font = .CustomPretendarFont(.Medium, forTextStyle: .callout)
            $0.textColor = .BrandGray3
            $0.textAlignment = .right
            $0.text = "사용 중인 이용권이 없습니다."
        }
        
        tvingCashLabel.do {
            $0.font = .CustomPretendarFont(.Medium, forTextStyle: .callout)
            $0.textColor = .BrandGray3
            $0.addImageBeforeText(imageName: "cashLogo", text: " 티빙캐시")
        }
        
        myCash.do {
            $0.font = .CustomPretendarFont(.Medium, forTextStyle: .headline)
            $0.textColor = .white
            $0.textAlignment = .right
            $0.text = "0"
        }
        
        subscriptionGuideLabel.do {
            $0.textColor = .BrandGray2
            $0.addImagesMiddleOfText(firstImage: "TVNLogo", secondImage: "JTBCLogo", formerText: "이용권을 구매하고 ", latterText: " 등 인기 TV프로그램과\n다양한 영화 콘텐츠를 자유롭게 시청하세요!")
            $0.numberOfLines = 2
        }
    
        guideBoxChevronImageView.do {
            let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 20)
            $0.image = UIImage(systemName: "chevron.right", withConfiguration: symbolConfiguration)
            $0.tintColor = .BrandGray2
            $0.contentMode = .scaleAspectFit
        }
    }
    
    private func setLayout() {
        profileTopStack.addArrangedSubview(userImage)
        profileTopStack.addArrangedSubview(userName)
        
        profileSubscriptionStack.addArrangedSubview(mySubscription)
        profileSubscriptionStack.addArrangedSubview(currentSubscription)
        
        profileCashStack.addArrangedSubview(tvingCashLabel)
        profileCashStack.addArrangedSubview(myCash)
        
//        profileMyInfoStack.addArrangedSubview(profileSubscriptionStack)
//        profileMyInfoStack.addArrangedSubview(profileCashStack)
        
        subscriptionGuideBox.addArrangedSubview(subscriptionGuideLabel)
        subscriptionGuideBox.addArrangedSubview(guideBoxChevronImageView)
        
        self.addSubviews(profileTopStack, profileModifyButton, profileMyInfoStack, subscriptionGuideBox, profileSubscriptionStack, profileCashStack)
        
        profileTopStack.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.height.equalTo(80)
            $0.width.equalTo(250)
            $0.top.equalToSuperview().inset(10)
        }
        
        profileModifyButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.centerY.equalTo(profileTopStack.snp.centerY)
            $0.width.equalTo(70)
            $0.height.equalTo(25)
        }
        
        profileMyInfoStack.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.top.equalTo(profileTopStack.snp.bottom).offset(15)
            $0.height.equalTo(90)
        }
        
        subscriptionGuideBox.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.top.equalTo(profileMyInfoStack.snp.bottom).offset(12)
            $0.height.equalTo(70)
        }
        
        profileSubscriptionStack.snp.makeConstraints {
            $0.top.equalTo(profileMyInfoStack.snp.top).inset(15)
            $0.leading.equalToSuperview().inset(30)
            $0.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(25)
        }
        
        profileCashStack.snp.makeConstraints {
            $0.top.equalTo(profileSubscriptionStack.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(30)
            $0.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(25)
        }
        
        userImage.snp.makeConstraints {
            $0.size.equalTo(74)
            $0.leading.equalToSuperview()
        }
        
        mySubscription.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.width.equalTo(100)
        }
        
        currentSubscription.snp.makeConstraints {
            $0.width.equalTo(200)
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalTo(mySubscription.snp.centerY)
        }
        
        tvingCashLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.width.equalTo(100)
        }
        
        myCash.snp.makeConstraints {
            $0.centerY.equalTo(tvingCashLabel.snp.centerY)
//            $0.trailing.equalToSuperview().inset(10)
            $0.width.equalTo(200)
        }
        
        subscriptionGuideLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileHeaderView {
    func cofigureName(userName: String) {
        self.userName.text = userName
    }
}

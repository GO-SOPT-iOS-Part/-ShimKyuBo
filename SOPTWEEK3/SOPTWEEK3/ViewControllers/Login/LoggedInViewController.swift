//
//  LoggedInViewController.swift
//  SOPTWEEK3
//
//  Created by KYUBO A. SHIM on 2023/04/30.
//

import UIKit

import SnapKit
import Then

    // MARK: - VC for getting passed texts
final class LoggedInViewController: UIViewController {
    
    private var userName: String?
    weak var delegate: LogInDelegate?
    
    // MARK: - UIComponents
    private let tvingLogo = UIImageView().then {
        $0.image = UIImage(named: "TVing")
        $0.contentMode = .scaleAspectFill
    }
    
    private let idLabel = UILabel().then {
        $0.numberOfLines = 2
        $0.textAlignment = .center
        $0.textColor = .white
        $0.font = .CustomPretendarFont(.Bold, forTextStyle: .title2)
    }
    
    private lazy var moveToHomeViewButton = UIButton(type: .system, primaryAction: UIAction(handler: { [weak self] _ in
        let nextVC = HomeViewController()
//        guard let userName else {}
        nextVC.passUserName(name: self?.userName)
        
        self?.navigationController?.pushViewController(nextVC, animated: true)
    })).then {
        $0.titleLabel?.font = .CustomPretendarFont(.SemiBold, forTextStyle: .subheadline)
        $0.setTitle("메인으로", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .MainColor
        $0.layer.cornerRadius = 3
    }
    
    // MARK: - VC Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        basicSetup()
        layouts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Setups
    private func basicSetup() {
        view.backgroundColor = .black
    }
    
    private func layouts() {
        lazy var kkk = UIImage()
        
        view.addSubviews(tvingLogo, idLabel, moveToHomeViewButton)
        
        tvingLogo.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalToSuperview()
            $0.height.equalTo(tvingLogo.snp.width).dividedBy(1.7)
        }
        
        idLabel.snp.makeConstraints {
            $0.top.equalTo(tvingLogo.snp.bottom).offset(70)
            $0.centerX.equalToSuperview()
        }
        
        moveToHomeViewButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(66)
            $0.height.equalTo(52)
        }
    }
}

    // MARK: - Extension for LogInDelegate
extension LoggedInViewController: LogInDelegate {
    func passId(_ id: String?) {
        guard let id else { return }
        idLabel.text = "\(id) 님\n 반가워요!"
        userName = id
    }
}

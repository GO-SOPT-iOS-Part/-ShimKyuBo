//
//  HomeViewController.swift
//  SOPTWEEK3
//
//  Created by KYUBO A. SHIM on 2023/04/30.
//

import UIKit

import SnapKit
import Then

final class HomeViewController: UIViewController {
    private var userName: String? = "Doosan"
//    private var userName: String?
    
    private lazy var headerBarView = HomeHeaderCustomBarView()
    private let headerTapView = HomeHeaderTapView()
    private let contentView = HomeContentView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        headerBarView.do {
            $0.profileButton.addTarget(self, action: #selector(moveToProfileView), for: .touchUpInside)
        }
                
        view.addSubviews(contentView, headerBarView, headerTapView)
        
        contentView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.top.equalTo(view.snp.top).offset(-110)
        }
        
        headerBarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(35)
        }
        
        headerTapView.snp.makeConstraints {
            $0.top.equalTo(headerBarView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    @objc
    private func moveToProfileView() {
        let nextVC = ProfileViewController()
        nextVC.passUserName(name: userName)
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension HomeViewController {
    func passUserName(name: String?) {
        self.userName = name
    }
}

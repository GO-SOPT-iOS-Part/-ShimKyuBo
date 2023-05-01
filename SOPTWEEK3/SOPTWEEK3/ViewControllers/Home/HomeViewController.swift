//
//  HomeViewController.swift
//  SOPTWEEK3
//
//  Created by KYUBO A. SHIM on 2023/04/30.
//

import UIKit

import SnapKit
import Then

class HomeViewController: UIViewController {
//
//    override func loadView() {
//        self.view =
//    }

    private let headerBarView = HomeHeaderCustomBarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(headerBarView)
        
        headerBarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(45)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
}

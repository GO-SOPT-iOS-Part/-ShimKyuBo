//
//  ViewController.swift
//  SOPT WEEK2
//
//  Created by KYUBO A. SHIM on 2023/04/13.
//

import UIKit

import Then
import SnapKit

class HomeViewController: UIViewController {
    
    let label = UILabel().then {
        $0.text = "안녕 빡빡이 아저씨, 친구들이야."
        $0.font = .CustomPretendarFont(.ExtraBold, forTextStyle: .headline)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}


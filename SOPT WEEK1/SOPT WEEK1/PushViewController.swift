//
//  PushViewController.swift
//  SOPT WEEK1
//
//  Created by KYUBO A. SHIM on 2023/04/07.
//

import UIKit

class PushViewController: UIViewController {

    private let goBackLabel: UILabel = {
        let label = UILabel()
        label.text = "안돼 돌아가. 돌아가라고"
        label.font = .preferredFont(forTextStyle: .title2)
        label.textColor = .blue
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        layout()
    }
    
    private func layout() {
        view.addSubview(goBackLabel)
        goBackLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            goBackLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goBackLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

}

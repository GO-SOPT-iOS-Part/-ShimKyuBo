//
//  PushViewController.swift
//  Sopt iOS Week1
//
//  Created by KYUBO A. SHIM on 2023/04/01.
//

import UIKit

final class PushViewController: UIViewController {
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.isUserInteractionEnabled = true
        label.textColor = .white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        tapButton()
        layouts()
    }
    
    private func tapButton() {
        let popTapped = UITapGestureRecognizer(target: self, action: #selector(dismissing(sender:)))
        label.addGestureRecognizer(popTapped)
    }
    
    private func layouts() {
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setName(name: String?) {
        label.text = name
    }
    
    @objc
    private func dismissing(sender: UITapGestureRecognizer) {
        print("kkkkkk")
        self.navigationController?.popViewController(animated: true)
    }
    
    deinit {
        print("Push Bye POPOPOPOPOPOP")
    }
}

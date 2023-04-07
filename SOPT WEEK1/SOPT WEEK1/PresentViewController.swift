//
//  PresentViewController.swift
//  SOPT WEEK1
//
//  Created by KYUBO A. SHIM on 2023/04/07.
//

import UIKit

class PresentViewController: UIViewController {
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .purple
        label.font = .preferredFont(forTextStyle: .callout)
        label.numberOfLines = 3
        label.isUserInteractionEnabled = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemOrange
        gestureSetup()
        layout()
    }
    
    private func layout() {
        view.addSubview(mainLabel)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func gestureSetup() {
        let labelTapped = UIGestureRecognizer(target: self, action: #selector(dismissTap))
        mainLabel.addGestureRecognizer(labelTapped)
    }
    
    @objc
    private func dismissTap() {
        self.dismiss(animated: true)
    }
}

extension PresentViewController {
    func setLabel(label: String?) {
        guard let label else { return }
        let isLabelEmpty = label.isEmpty
        switch isLabelEmpty {
        case true :
            self.mainLabel.text = "Type Something back there."
        default:
            self.mainLabel.text = label
        }
    }
}

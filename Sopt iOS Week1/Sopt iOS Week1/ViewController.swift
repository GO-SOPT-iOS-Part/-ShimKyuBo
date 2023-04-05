//
//  ViewController.swift
//  Sopt iOS Week1
//
//  Created by KYUBO A. SHIM on 2023/04/01.
//

import UIKit

final class ViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "SOPT 세미나 1주차"
        label.textColor = .orange
        label.font = .systemFont(ofSize: 25, weight: .light)
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "alala")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "이름이 무엇인가요?"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.textColor = .orange
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.clearButtonMode = .always
        textField.font = .systemFont(ofSize: 18, weight: .black)
        textField.placeholder = "이름을 적어주세요."
        textField.textColor = .orange
        return textField
    }()
    
    private lazy var presentTappedButton: UIButton = {
        let button = UIButton(type: .system, primaryAction: UIAction(handler: { _ in
            print("SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고")
            let presentVC = PresentViewController()
            presentVC.modalPresentationStyle = .formSheet
            presentVC.modalTransitionStyle = .crossDissolve
            self.navigationController?.present(presentVC, animated: true)
        }))
        button.setTitle("Present", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        button.backgroundColor = .orange
        button.tintColor = .white
        button.layer.cornerRadius = 15
        return button
    }()
    
    private lazy var pushTappedButton: UIButton = {
        let button = UIButton(type: .system, primaryAction: UIAction(handler: { _ in
            print("SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고SOPT 아요 최고")
            let pushVC = PushViewController()
            pushVC.setName(name: self.textField.text)
            self.navigationController?.pushViewController(pushVC, animated: true)
        }))
        button.setTitle("Push", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        button.backgroundColor = .systemPink
        button.tintColor = .white
        button.layer.cornerRadius = 15
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        basicSetup()
        layouts()
    }
    
    private func basicSetup() {
        view.backgroundColor = .white
    }
    
    private func layouts() {
        [titleLabel, imageView, label, textField, presentTappedButton, pushTappedButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            titleLabel.widthAnchor.constraint(equalToConstant: 200),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            view.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 50),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            label.widthAnchor.constraint(equalToConstant: 400),
            label.heightAnchor.constraint(equalToConstant: 20),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 25),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            view.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 40),
            textField.heightAnchor.constraint(equalToConstant: 40),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            presentTappedButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 15),
            presentTappedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            view.trailingAnchor.constraint(equalTo: presentTappedButton.trailingAnchor, constant: 30),
            presentTappedButton.heightAnchor.constraint(equalToConstant: 60),
            presentTappedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pushTappedButton.topAnchor.constraint(equalTo: presentTappedButton.bottomAnchor, constant: 15),
            pushTappedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            view.trailingAnchor.constraint(equalTo: pushTappedButton.trailingAnchor, constant: 30),
            pushTappedButton.heightAnchor.constraint(equalToConstant: 60),
            pushTappedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }
}


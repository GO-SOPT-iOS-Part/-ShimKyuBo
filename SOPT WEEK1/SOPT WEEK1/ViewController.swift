//
//  ViewController.swift
//  SOPT WEEK1
//
//  Created by KYUBO A. SHIM on 2023/04/07.
//

import UIKit

final class ViewController: UIViewController {
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "SOPT WEEK1"
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.textColor = .systemMint
        label.textAlignment = .center
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "hi")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.shadowColor = UIColor.red.cgColor
        imageView.layer.shadowOpacity = 0.6
        imageView.layer.shadowRadius = 10
        imageView.layer.shadowOffset = CGSize(width: 5, height: 5)
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름이 무엇인가요?"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .blue
        label.textAlignment = .center
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이름을 입력해주세요"
        textField.clearButtonMode = .whileEditing
        textField.tintColor = .green
        textField.font = .boldSystemFont(ofSize: 20)
        textField.autocorrectionType = .no
        return textField
    }()
    
    private lazy var presentButton: UIButton = {
        let button = UIButton(primaryAction: UIAction(handler: { _ in
            let presentVC = PresentViewController()
            presentVC.modalPresentationStyle = .formSheet
            presentVC.setLabel(label: self.nameTextField.text)
            self.navigationController?.present(presentVC, animated: true)
        }))
        button.setTitle("present", for: .normal)
        button.backgroundColor = .systemOrange
        button.titleLabel?.font = .preferredFont(forTextStyle: .title2)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        return button
    }()
    
    private lazy var pushButton: UIButton = {
        let button = UIButton(primaryAction: UIAction(handler: { _ in
            let pushVC = PushViewController()
            self.navigationController?.pushViewController(pushVC, animated: true)
        }))
        button.setTitle("push", for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .title2)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        setLayout()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)
    }
}

private extension ViewController {
    
    func style() {
        view.backgroundColor = .white
    }
    
    func setLayout() {
        [mainLabel, imageView, nameLabel, nameTextField,
         presentButton, pushButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 30),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40),
                                     nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                                     nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)])
        
        NSLayoutConstraint.activate([nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
                                     nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                                     nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                                     nameTextField.heightAnchor.constraint(equalToConstant: 48)])
        
        NSLayoutConstraint.activate([presentButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
                                     presentButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                                     presentButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                                     presentButton.heightAnchor.constraint(equalToConstant: 70)])
        
        NSLayoutConstraint.activate([pushButton.topAnchor.constraint(equalTo: presentButton.bottomAnchor, constant: 20),
                                     pushButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                                     pushButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                                     pushButton.heightAnchor.constraint(equalToConstant: 70)])
    }
}

//
//  CreatingNicknameViewController.swift
//  SOPT WEEK2
//
//  Created by KYUBO A. SHIM on 2023/04/14.
//

import UIKit

import SnapKit
import Then

    // MARK: - VC for Bottom Sheet
final class CreatingNicknameViewController: UIViewController {
    // NicknameDelegate
    weak var delegate: NicknameDelegate?
    
    // MARK: - UI Components
    private let mainLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .CustomPretendarFont(.Medium, forTextStyle: .title2)
        $0.text = "닉네임을 입력해주세요."
    }
    
    private let nicknameTextField = UITextField().then {
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
        $0.font = .CustomPretendarFont(.SemiBold, forTextStyle: .subheadline)
        $0.layer.cornerRadius = 3
        $0.attributedPlaceholder = NSAttributedString(string: "닉네임", attributes: [NSAttributedString.Key.foregroundColor: UIColor.BrandGray4])
        $0.leftViewMode = .always
        $0.leftView = .init(frame: CGRect(x: 0, y: 0, width: 22, height: 10))
        $0.textColor = .BrandGray4
        $0.backgroundColor = .BrandGray2
    }
        
    private lazy var saveButton = UIButton(type: .system, primaryAction: UIAction(handler: { [weak self] _ in
        // Passing Nickname to HomeVC
        self?.delegate?.passNickname(self?.nicknameTextField.text)
        self?.dismiss(animated: true)
    })).then {
        $0.isEnabled = false
        $0.titleLabel?.font = .CustomPretendarFont(.SemiBold, forTextStyle: .subheadline)
        $0.setTitle("저장하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .BrandGray1
        $0.layer.cornerRadius = 12
    }
    
    // MARK: - VC Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        basicSetup()
        layouts()
    }
    
    // MARK: - Setups
    private func basicSetup() {
        view.backgroundColor = .white
        
        nicknameTextField.delegate = self
    }
    
    private func layouts() {
        view.addSubviews(mainLabel, nicknameTextField, saveButton)
        
        mainLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.leading.equalTo(20)
        }
        
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(mainLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
        
        saveButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

    // MARK: - Extension for UITextFieldDelegate
extension CreatingNicknameViewController: UITextFieldDelegate {
    // Return false when 
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let titleCharacter = string.cString(using: .utf8)
        let isBackSpace = strcmp(titleCharacter, "\\b")
        if string.hasCharacters() || isBackSpace == -92 {
            return true
        }
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if text.count > 0 {
            saveButton.isEnabled = true
            saveButton.backgroundColor = .MainColor
        } else {
            saveButton.isEnabled = false
            saveButton.backgroundColor = .BrandGray1
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}

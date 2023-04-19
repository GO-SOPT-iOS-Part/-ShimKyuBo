//
//  ViewController.swift
//  SOPT WEEK2
//
//  Created by KYUBO A. SHIM on 2023/04/13.
//

import UIKit

import Then
import RxSwift
import RxCocoa
import SnapKit

    // MARK: - VC for HomeView
final class HomeViewController: UIViewController {
    
    weak var delegate: LogInDelegate?
//    private var loginUIAction: UIAction?

    // MARK: - RxSwift Properties
    private var loginViewModel = LoginViewModel()
    var disposeBag = DisposeBag()
    private let isEmailFine: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    // MARK: - Property for checking whether nickname exists
    private var nickname: String?
    
    // MARK: - UI Components
    private let customNavigationView = CustomNavigationBar()
    
    private let mainLabel = UILabel().then {
        $0.textColor = .BrandGray1
        $0.font = .CustomPretendarFont(.Medium, forTextStyle: .title2)
        $0.text = "TVING ID 로그인"
    }
    
    private let idTextfield = UITextField().then {
        $0.returnKeyType = .next
        $0.keyboardType = .emailAddress
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
        $0.font = .CustomPretendarFont(.SemiBold, forTextStyle: .callout)
        $0.layer.cornerRadius = 3
        $0.textContentType = .emailAddress
        $0.attributedPlaceholder = NSAttributedString(string: "아이디", attributes: [NSAttributedString.Key.foregroundColor: UIColor.BrandGray2])
        $0.leftViewMode = .always
        $0.leftView = .init(frame: CGRect(x: 0, y: 0, width: 22, height: 10))
        $0.textColor = .BrandGray2
        $0.backgroundColor = .BrandGray4
    }
    
    private let checkEmailValidPointView = UIImageView(image: UIImage(named: "emailPoint")).then {
        $0.isHidden = true
        $0.contentMode = .scaleAspectFit
    }
    
    private let clearButtonForIdImageView = UIImageView().then {
        $0.isHidden = true
        $0.isUserInteractionEnabled = true
        $0.image = UIImage(named: "clearButtonIcon")
        $0.contentMode = .scaleAspectFit
    }
    
    private let passwordTextfield = UITextField().then {
        $0.returnKeyType = .done
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
        $0.font = .CustomPretendarFont(.SemiBold, forTextStyle: .callout)
        $0.layer.cornerRadius = 3
        $0.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: [NSAttributedString.Key.foregroundColor: UIColor.BrandGray2])
        $0.leftViewMode = .always
        $0.leftView = .init(frame: CGRect(x: 0, y: 0, width: 22, height: 10))
        $0.textColor = .BrandGray2
        $0.backgroundColor = .BrandGray4
        $0.isSecureTextEntry = true
        $0.textContentType = .password
    }
    
    private let clearButtonForPasswordImageView = UIImageView().then {
        $0.isHidden = true
        $0.isUserInteractionEnabled = true
        $0.image = UIImage(named: "clearButtonIcon")
        $0.contentMode = .scaleAspectFit
    }
    
    private let toggleTextSecurityImageView = UIImageView().then {
        $0.isHidden = true
        $0.isUserInteractionEnabled = true
        $0.image = UIImage(named: "eyeIcon")
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var loginButton = UIButton(type: .system).then {
        $0.isEnabled = false
        $0.titleLabel?.font = .CustomPretendarFont(.SemiBold, forTextStyle: .subheadline)
        $0.setTitleColor(.BrandGray2, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 3
        $0.layer.borderColor = UIColor.BrandGray4.cgColor
        $0.backgroundColor = .clear
        $0.setTitle("로그인하기", for: .normal)
    }
    
    private let findMyIdButton = UIButton(type: .system).then {
        $0.titleLabel?.font = .CustomPretendarFont(.SemiBold, forTextStyle: .subheadline)
        $0.backgroundColor = .clear
        $0.setTitle("아이디 찾기", for: .normal)
        $0.setTitleColor(.BrandGray2, for: .normal)
    }
    
    private let findMyPasswordButton = UIButton(type: .system).then {
        $0.titleLabel?.font = .CustomPretendarFont(.SemiBold, forTextStyle: .subheadline)
        $0.backgroundColor = .clear
        $0.setTitle("비밀번호 찾기", for: .normal)
        $0.setTitleColor(.BrandGray2, for: .normal)
    }
    
    private let questionLabel = UILabel().then {
        $0.font = .CustomPretendarFont(.SemiBold, forTextStyle: .subheadline)
        $0.textColor = .BrandGray3
        $0.text = "아직 계정이 없으신가요?"
    }
    
    private lazy var makeNickNameButton = UIButton(type: .system, primaryAction: UIAction(handler: { [weak self] _ in
        let bottomSheetVC = CreatingNicknameViewController()
        bottomSheetVC.modalPresentationStyle = .pageSheet
        bottomSheetVC.delegate = self
        
        if let sheet = bottomSheetVC.sheetPresentationController {
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 30
            sheet.detents = [
                .custom { context in
                    return context.maximumDetentValue * 0.55
                }
            ]
        }
        self?.present(bottomSheetVC, animated: true)
    })).then {
        $0.setTitleColor(.BrandGray2, for: .normal)
        $0.titleLabel?.font = .CustomPretendarFont(.Regular, forTextStyle: .subheadline)
        $0.setTitle("닉네임 만들러가기", for: .normal)
        $0.setUnderline()
    }
    
    private lazy var stackViewForFinding = UIStackView(arrangedSubviews: [findMyIdButton, dividingLineView, findMyPasswordButton]).then {
        $0.spacing = 30
        $0.distribution = .equalSpacing
        $0.axis = .horizontal
    }
    
    private let dividingLineView = UIView().then {
        $0.backgroundColor = .BrandGray4
    }
    
    // MARK: - VC Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        basicSetup()
        layouts()
        actions()
        bindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Setups
    private func basicSetup() {
        view.backgroundColor = .black
        idTextfield.delegate = self
        passwordTextfield.delegate = self
    }
    
    private func layouts() {
        view.addSubviews(customNavigationView, mainLabel, idTextfield, checkEmailValidPointView, clearButtonForIdImageView, passwordTextfield, clearButtonForPasswordImageView, toggleTextSecurityImageView, loginButton, stackViewForFinding, questionLabel, makeNickNameButton)
        
        customNavigationView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
        mainLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(customNavigationView.snp.bottom).offset(10)
        }
        
        idTextfield.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(mainLabel.snp.bottom).offset(30)
            $0.height.equalTo(52)
        }
        
        clearButtonForIdImageView.snp.makeConstraints {
            $0.centerY.equalTo(idTextfield.snp.centerY)
            $0.trailing.equalTo(idTextfield.snp.trailing).inset(20)
            $0.size.equalTo(20)
        }
        
        checkEmailValidPointView.snp.makeConstraints {
            $0.size.equalTo(7)
            $0.centerX.equalTo(idTextfield.snp.leading).inset(15)
            $0.centerY.equalTo(idTextfield.snp.top).inset(15)
        }
        
        passwordTextfield.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(idTextfield.snp.bottom).offset(7)
            $0.height.equalTo(52)
        }
        
        clearButtonForPasswordImageView.snp.makeConstraints {
            $0.centerY.equalTo(passwordTextfield.snp.centerY)
            $0.trailing.equalTo(passwordTextfield.snp.trailing).inset(56)
            $0.size.equalTo(20)
        }
        
        toggleTextSecurityImageView.snp.makeConstraints {
            $0.centerY.equalTo(passwordTextfield.snp.centerY)
            $0.trailing.equalTo(passwordTextfield.snp.trailing).inset(20)
            $0.size.equalTo(20)
        }
        
        loginButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(passwordTextfield.snp.bottom).offset(21)
            $0.height.equalTo(52)
        }
        
        stackViewForFinding.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(loginButton.snp.bottom).offset(30)
        }
        
        dividingLineView.snp.makeConstraints {
            $0.width.equalTo(1)
            $0.height.equalTo(12)
        }
        
        questionLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(50)
            $0.top.equalTo(stackViewForFinding.snp.bottom).offset(28)
        }
        
        makeNickNameButton.snp.makeConstraints {
            $0.leading.equalTo(questionLabel.snp.trailing).offset(30)
            $0.centerY.equalTo(questionLabel.snp.centerY)
        }
    }
    
    // MARK: - Rx Bindings
    private func bindings() {
        idTextfield.rx.text
            .bind(to: loginViewModel.input.emailText)
            .disposed(by: disposeBag)
        
        passwordTextfield.rx.text
            .bind(to: loginViewModel.input.passwordText)
            .disposed(by: disposeBag)
        
        loginViewModel.output.isEmailValid
            .skip(1)
            .drive(checkEmailValidPointView.rx.isHidden)
            .disposed(by: disposeBag)
        
        loginViewModel.output.isConfirmValid
            .map { $0 }
            .drive { [weak self] bool in
                switch bool {
                case true:
                    self?.loginButton.backgroundColor = .MainColor
                    self?.loginButton.setTitleColor(.white, for: .normal)
                    self?.loginButton.layer.borderWidth = 0
                    self?.loginButton.isEnabled = true
                case false:
                    self?.loginButton.backgroundColor = .clear
                    self?.loginButton.setTitleColor(.BrandGray2, for: .normal)
                    self?.loginButton.layer.borderWidth = 1
                    self?.loginButton.isEnabled = false
                }
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - Gesture Setups
    private func actions() {
        let clearButtonTappedOnId = UITapGestureRecognizer(target: self, action: #selector(clearTextOnId))
        let clearButtonTappedOnPassword = UITapGestureRecognizer(target: self, action: #selector(clearTextOnPassword))
        let toggleSecurityButtonTapped = UITapGestureRecognizer(target: self, action: #selector(toggleSecurity))
        let keyboardGoesDownWhenViewTapped = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        
        clearButtonForIdImageView.addGestureRecognizer(clearButtonTappedOnId)
        clearButtonForPasswordImageView.addGestureRecognizer(clearButtonTappedOnPassword)
        toggleTextSecurityImageView.addGestureRecognizer(toggleSecurityButtonTapped)
        view.addGestureRecognizer(keyboardGoesDownWhenViewTapped)
    }
    
}
    
    // MARK: - Requisite Actions
extension HomeViewController {
    /// 로그인 액션
    @objc
    private func loginAction() {
        let passingText: String?
        let nicknameExists: Bool = self.checkEmailValid() == true && self.nickname != nil
        let nicknameNil: Bool = self.checkEmailValid() == true && self.nickname == nil
        
        let nextVC = LoggedInViewController()
        self.delegate = nextVC
        
        if nicknameNil {
            passingText = self.idTextfield.text
        } else if nicknameExists {
            passingText = self.nickname
        } else {
            self.animateWhenEmailIsNotValid()
            return
        }
        
        self.delegate?.passId(passingText)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    private func checkEmailValid() -> Bool {
        loginViewModel.output.isEmailValid
            .asObservable()
            .bind(to: isEmailFine)
            .disposed(by: disposeBag)
        
        let emailValidation = isEmailFine.value
        if emailValidation == false {
            animateWhenEmailIsNotValid()
        }
        
        return emailValidation
    }
    
    // Animation when Email doesn't follow the RegEx
    private func animateWhenEmailIsNotValid() {
        let animation = CAKeyframeAnimation(keyPath: "position.x")
        animation.values = [0, -3, 0, 3, 0]
        animation.keyTimes = [0, 0.08, 0.17, 0.26, 0.35]
        animation.duration = 0.35
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.isAdditive = true
        checkEmailValidPointView.layer.add(animation, forKey: nil)
        idTextfield.layer.add(animation, forKey: nil)
    }
    
    @objc
    private func viewTapped() {
        view.endEditing(true)
        passwordTextfield.isSecureTextEntry = true
    }
    
    @objc
    private func clearTextOnId() {
        idTextfield.text = ""
        idTextfield.becomeFirstResponder()
    }
    
    @objc
    private func clearTextOnPassword() {
        passwordTextfield.text = ""
        passwordTextfield.becomeFirstResponder()
    }
    
    @objc
    private func toggleSecurity(_ textField: UITextField) {
        passwordTextfield.isSecureTextEntry.toggle()
        passwordTextfield.becomeFirstResponder()
        toggleTextSecurityImageView.image = !passwordTextfield.isSecureTextEntry ? UIImage(named: "eyeOpenIcon") : UIImage(named: "eyeIcon")
    }
}

    // MARK: - Extension for UITextFieldDelegate
extension HomeViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == passwordTextfield {
            clearButtonForPasswordImageView.isHidden = false
            toggleTextSecurityImageView.isHidden = false
            textField.layer.borderColor = UIColor.BrandGray2.cgColor
            textField.layer.borderWidth = 1
        } else {
            clearButtonForIdImageView.isHidden = false
            textField.layer.borderColor = UIColor.BrandGray2.cgColor
            textField.layer.borderWidth = 1
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == passwordTextfield {
            clearButtonForPasswordImageView.isHidden = true
            toggleTextSecurityImageView.isHidden = true
            textField.isSecureTextEntry = true
            textField.layer.borderColor = UIColor.BrandGray2.cgColor
            textField.layer.borderWidth = 0
        } else {
            clearButtonForIdImageView.isHidden = true
            textField.layer.borderColor = UIColor.BrandGray2.cgColor
            textField.layer.borderWidth = 0
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == idTextfield {
            passwordTextfield.becomeFirstResponder()
        } else {
            // 키보드의 Return 을 눌러도 똑같이 버튼과 작동
            passwordTextfield.resignFirstResponder()
            self.loginAction()
        }
        
        return true
    }
}

    // MARK: - Extension for NicknameDelegate
extension HomeViewController: NicknameDelegate {
    func passNickname(_ name: String?) {
        guard let name else { return }
        self.nickname = name
    }
}

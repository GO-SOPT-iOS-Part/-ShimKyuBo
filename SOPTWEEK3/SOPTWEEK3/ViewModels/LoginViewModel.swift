//
//  LoginViewModel.swift
//  SOPTWEEK3
//
//  Created by KYUBO A. SHIM on 2023/04/30.
//

import UIKit

import RxSwift
import RxCocoa

    // MARK: - Using MVVM with RxSwift using Input and Output Protocol
final class LoginViewModel: ViewModelType {
    // 의존성은 왜 필요할까?
    struct Dependency {
        var email: String?
        var password: String?
    }
    
    struct Input {
        // 왜 AnyObserver 일까? 흠 왜
        var emailText: AnyObserver<String?>
        var passwordText: AnyObserver<String?>
    }
    
    struct Output {
        var isEmailValid: Driver<Bool>
        var isConfirmValid: Driver<Bool>
    }
    
    let dependency: Dependency
    var disposeBag: DisposeBag = DisposeBag()
    let input: Input
    let output: Output
    
    private let emailText: BehaviorSubject<String?>
    private let passwordText: BehaviorSubject<String?>
    
    init(dependency: Dependency = Dependency(email: nil, password: nil)) {
        self.dependency = dependency
        
        // Streams
        let emailText = BehaviorSubject<String?>(value: nil)
        let passwordText = BehaviorSubject<String?>(value: nil)
        
        let isEmailEnabled: Driver<Bool> = emailText
            .map(emailValidation)
            .asDriver(onErrorJustReturn: false)
        
        let isConfirmValid: Driver<Bool> = Observable.combineLatest(emailText, passwordText)
            .map(confirmValidation)
            .asDriver(onErrorJustReturn: false)
        
        // Input & Output
        self.input = Input(emailText: emailText.asObserver(), passwordText: passwordText.asObserver())
        self.output = Output(isEmailValid: isEmailEnabled, isConfirmValid: isConfirmValid)
        
        // Binding
        self.emailText = emailText
        self.passwordText = passwordText
    }
}

    // MARK: - VM 의 Life Cycle 을 관리하기 위해 따로 뺀 func
    /// 따로 빼지 않으면, init 에서 쓸 수 없다.
private func emailValidation(_ email: String?) -> Bool {
    let emailRegEx = "[A-Za-z0-9.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,40}"
    let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: email)
}

private func confirmValidation(email: String?, password: String?) -> Bool {
    return email?.isEmpty == false && password?.isEmpty == false
}

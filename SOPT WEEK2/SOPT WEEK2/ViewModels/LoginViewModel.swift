//
//  LoginViewModel.swift
//  SOPT WEEK2
//
//  Created by KYUBO A. SHIM on 2023/04/13.
//

import UIKit

import RxSwift
import RxCocoa

final class LoginViewModel: ViewModelType {
    struct Dependency {
        var email: String?
        var password: String?
    }
    
    struct Input {
        // 왜 AnyObserver 일까?
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
        
        var isEmailEnabled: Driver<Bool> = emailText
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

private func emailValidation(_ email: String?) -> Bool {
    let emailRegEx = "[A-Za-z0-9.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,40}"
    let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: email)
}

private func confirmValidation(email: String?, password: String?) -> Bool {
    return email?.isEmpty == false && password?.isEmpty == false
}

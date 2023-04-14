//
//  Protocols.swift
//  SOPT WEEK2
//
//  Created by KYUBO A. SHIM on 2023/04/13.
//

import RxSwift

    // MARK: - Protocol for ViewModel
protocol ViewModelType {
    associatedtype Dependency
    associatedtype Input
    associatedtype Output
    
    var dependency: Dependency { get }
    var disposeBag: DisposeBag { get set }
    
    var input: Input { get }
    var output: Output { get }
    
    init(dependency: Dependency)
}

    // MARK: - Protocol for Pass the Id to the next VC
protocol LogInDelegate: AnyObject {
    func passId(_ id: String?)
}

    // MARK: - Protocol for Pass the Nickname to HomeVC
protocol NicknameDelegate: AnyObject {
    func passNickname(_ name: String?)
}

//
//  Protocols.swift
//  SOPT WEEK2
//
//  Created by KYUBO A. SHIM on 2023/04/13.
//

import RxSwift

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

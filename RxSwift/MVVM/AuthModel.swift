//  AuthViewModel.swift
//  fooiy-ios
//
//  Created by 김상우 on 2022/05/09.
// RxSwift + MVVM : https://ios-development.tistory.com/140
// bind 개념 : https://duwjdtn11.tistory.com/628

import Foundation
import RxSwift
import RxCocoa

protocol PhoneNumberIOViewModel {
    associatedtype PhoneNumberInput
    associatedtype PhoneNumberOutput
    
    var phoneNumberInput: PhoneNumberInput { get }
    var phoneNumberOutput: PhoneNumberOutput { get }
    var realPhoneNumberOutput: PhoneNumberOutput { get }
}

class AuthViewModel: PhoneNumberIOViewModel {
    let phoneNumberInput: PhoneNumberInput
    let phoneNumberOutput: PhoneNumberOutput
    let realPhoneNumberOutput: PhoneNumberOutput
    
    init(input: PhoneNumberInput, dependency: String) {
        self.phoneNumberInput = input
        
        let rxResult = input.text.asObservable()
        
        self.phoneNumberOutput = PhoneNumberOutput(result: rxResult)
        self.realPhoneNumberOutput = PhoneNumberOutput(result: rxResult)
    }
    
}

extension AuthViewModel {
    struct PhoneNumberInput {
        let text: Observable<String>
    }
    
    struct PhoneNumberOutput {
        let result: Observable<String>
    }
    
    struct EmailOutput {
        let result: Observable<String>
    }
}



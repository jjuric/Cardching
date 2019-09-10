//
//  RegisterViewModel.swift
//  Cardching
//
//  Created by Jakov Juric on 09/09/2019.
//  Copyright © 2019 Jakov Juric. All rights reserved.
//

import Foundation

class RegisterViewModel {
    
    enum ErrorType {
        case emailError
        case passwordError
        case general
    }
    
    //MARK: - Callbacks
    var onRegister: (() -> Void)?
    var onError: ((ErrorType) -> Void)?
    
    //MARK: - Methods
    func register(with email: String, password: String, repeatedPassword: String) {
        guard password == repeatedPassword else { onError?(.passwordError); return }
        // Firebase register, check email in use
    }
}

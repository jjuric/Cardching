//
//  LoginViewModel.swift
//  Cardching
//
//  Created by Jakov Juric on 09/09/2019.
//  Copyright © 2019 Jakov Juric. All rights reserved.
//

import Foundation
import FirebaseAuth

class LoginViewModel: AuthViewModel {
    
    enum LoginError: String {
        case invalidEmail = "Email nije registriran"
        case invalidPassword = "Pogrešna lozinka"
        case unknown = "Došlo je do pogreške, probajte kasnije"
    }
    
    //MARK: - Callbacks
    var onShowRegistration: (() -> Void)?
    var onLoggedIn: (() -> Void)?
    var onErrorLogIn: ((String) -> Void)?
    
    // MARK: - Methods
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if let err = error {
                if let error = AuthErrorCode(rawValue: err._code){
                    switch error {
                    case .userNotFound:
                        self?.onErrorLogIn?(LoginError.invalidEmail.rawValue)
                    case .wrongPassword:
                        self?.onErrorLogIn?(LoginError.invalidPassword.rawValue)
                    default:
                        self?.onErrorLogIn?(LoginError.unknown.rawValue)
                    }
                    return
                }
            } else {
                self?.onLoggedIn?()
            }
        }
    }
    
    func showRegistration() {
        onShowRegistration?()
    }
}

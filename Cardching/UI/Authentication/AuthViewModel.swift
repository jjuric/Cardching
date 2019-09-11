//
//  AuthViewModel.swift
//  Cardching
//
//  Created by Jakov Juric on 11/09/2019.
//  Copyright © 2019 Jakov Juric. All rights reserved.
//

import Foundation

class AuthViewModel {
    // Email and Password validation
    func isEmailValid(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*.?&])[A-Za-z\\d$@$#!%*.?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
}

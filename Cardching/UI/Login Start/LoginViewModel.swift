//
//  LoginViewModel.swift
//  Cardching
//
//  Created by Jakov Juric on 09/09/2019.
//  Copyright © 2019 Jakov Juric. All rights reserved.
//

import Foundation
import UIKit

class LoginViewModel {
    
    //MARK: - Callbacks
    var onShowRegistration: (() -> Void)?
    var onLoggedIn: (() -> Void)?
    var onErrorLogIn: (() -> Void)?
    
    // MARK: - Methods
    func login(with email: String, password: String) {
        // Firebase login
    }
    
    func showRegistration() {
        onShowRegistration?()
    }
}

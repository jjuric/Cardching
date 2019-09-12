//
//  RegisterViewModel.swift
//  Cardching
//
//  Created by Jakov Juric on 09/09/2019.
//  Copyright © 2019 Jakov Juric. All rights reserved.
//

import Foundation
import FirebaseAuth
import Firebase

class RegisterViewModel: AuthViewModel {
    
    enum RegisterError: String {
        case passwordRepeat = "Lozinke ne odgovaraju."
        case emailFormat = "Email nije ispravan."
        case passwordStrength = "Lozinka mora imati najmanje 8 znakova, veliko slovo, malo slovo i poseban znak."
        case creatingUser = "Pogreška pri kreiranju korisnika. Probajte ponovno."
        case emailInUse = "Ovaj mail se već koristi"
    }
    
    //MARK: - Callbacks
    var onRegister: (() -> Void)?
    var onError: ((String) -> Void)?
    
    //MARK: - Methods
    func register(with email: String, password: String, repeatedPassword: String) {
        guard password == repeatedPassword else { onError?(RegisterError.passwordRepeat.rawValue); return }
        guard isEmailValid(email) else { onError?(RegisterError.emailFormat.rawValue); return }
        guard isPasswordValid(password) else { onError?(RegisterError.passwordStrength.rawValue); return }
        
        Auth.auth().fetchSignInMethods(forEmail: email, completion: { [weak self] (methods, error) in
            if let _ = error {
                self?.onError?(RegisterError.creatingUser.rawValue)
                return
            } else if let _ = methods {
                self?.onError?(RegisterError.emailInUse.rawValue)
                return
            } else {
                // If the email is not in use continue with register
                Auth.auth().createUser(withEmail: email, password: password) { [weak self] (result, error) in
                    if let _ = error {
                        self?.onError?(RegisterError.creatingUser.rawValue)
                        return
                    } else {
                        let db = Firestore.firestore()
                        db.collection("users").document(result!.user.uid).setData(["email" : result!.user.email!])
                        self?.onRegister?()
                    }
                }
            }
        })
    }
}

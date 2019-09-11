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
    
    enum ErrorType: String {
        case passwordRepeat = "Lozinke ne odgovaraju."
        case emailFormat = "Email nije ispravan."
        case passwordStrength = "Lozinka mora imati najmanje 8 znakova, veliko slovo, malo slovo i poseban znak."
        case creatingUser = "Pogreška pri kreiranju korisnika. Probajte ponovno."
        case emailInUse = "Ovaj mail se već koristi"
    }
    private var emailRegistered = true
    
    //MARK: - Callbacks
    var onRegister: (() -> Void)?
    var onError: ((String) -> Void)?
    
    //MARK: - Methods
    func register(with email: String, password: String, repeatedPassword: String) {
//        isEmailRegistered(email: email)
        guard password == repeatedPassword else { onError?(ErrorType.passwordRepeat.rawValue); return }
        guard isEmailValid(email) else { onError?(ErrorType.emailFormat.rawValue); return }
        guard isPasswordValid(password) else { onError?(ErrorType.passwordStrength.rawValue); return }
//        guard !emailRegistered else { onError?(ErrorType.emailInUse.rawValue); return }
        // Firebase register, check email in use
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (result, error) in
            if let _ = error {
                self?.onError?(ErrorType.creatingUser.rawValue)
                return
            } else {
                let db = Firestore.firestore()
                db.collection("users").document(result!.user.uid).setData(["email" : result!.user.email!])
                self?.onRegister?()
            }
        }
    }
    
    func isEmailRegistered(email: String) {
        Auth.auth().fetchSignInMethods(forEmail: email, completion: { [weak self] (methods, error) in
            
            if let error = error {
                print(error.localizedDescription)
            } else if let _ = methods {
                self?.emailRegistered = true
            } else {
                self?.emailRegistered = false
            }
        })
    }
}

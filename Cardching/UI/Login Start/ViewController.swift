//
//  ViewController.swift
//  Cardching
//
//  Created by Jakov Juric on 06/09/2019.
//  Copyright © 2019 Jakov Juric. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var loginLabel: UILabel!
    // MARK: - Views, lazy loading
    lazy var emailField: CustomFieldView = {
       let login = CustomFieldView()
        login.translatesAutoresizingMaskIntoConstraints = false
        login.configureFor(type: .email)
        view.addSubview(login)
        return login
    }()
    lazy var passwordField: CustomFieldView = {
       let password = CustomFieldView()
        password.configureFor(type: .password)
        view.addSubview(password)
        return password
    }()
    lazy var loginButton: UIButton = {
       let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Prijavi se", for: .normal)
        btn.titleLabel?.textColor = .white
        btn.titleLabel?.font = UIFont(name: "Quicksand-Bold", size: 18)
        btn.layer.cornerRadius = 30
        btn.backgroundColor = .gray
        btn.isEnabled = false
        view.addSubview(btn)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCallbacks()
        setupConstraints()
    }
    
    private func shouldEnableLogin() -> Bool {
        if !(passwordField.textField.text?.isEmpty)!, !(emailField.textField.text?.isEmpty)! {
            return true
        } else {
            return false
        }
    }
    
    private func setupConstraints() {
        emailField.anchor(top: (loginLabel.bottomAnchor, 40), leading: (view.leadingAnchor, 20), trailing: (view.trailingAnchor, 20), size: CGSize(width: 0, height: 52))
        passwordField.anchor(top: (emailField.bottomAnchor, 0), leading: (view.leadingAnchor, 20), trailing: (view.trailingAnchor, 20), size: CGSize(width: 0, height: 52))
        loginButton.anchor(top: (passwordField.bottomAnchor, 90), leading: (view.leadingAnchor, 20), trailing: (view.trailingAnchor, 20), size: CGSize(width: 315, height: 62))
    }
    
    private func addCallbacks() {
        emailField.onBeganEditing = { [weak self] in
            if (self?.shouldEnableLogin())! {
                self?.loginButton.isEnabled = true
                self?.loginButton.backgroundColor = .appPurple
            } else {
                self?.loginButton.isEnabled = false
                self?.loginButton.backgroundColor = .gray
            }
        }
        passwordField.onBeganEditing = { [weak self] in
            if (self?.shouldEnableLogin())! {
                self?.loginButton.isEnabled = true
                self?.loginButton.backgroundColor = .appPurple
            } else {
                self?.loginButton.isEnabled = false
                self?.loginButton.backgroundColor = .gray
            }
        }
        passwordField.onEndEditing = { [weak self] in
            if (self?.shouldEnableLogin())! {
                self?.loginButton.isEnabled = true
                self?.loginButton.backgroundColor = .appPurple
            } else {
                self?.loginButton.isEnabled = false
                self?.loginButton.backgroundColor = .gray
            }
        }
    }

}


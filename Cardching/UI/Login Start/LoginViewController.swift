//
//  ViewController.swift
//  Cardching
//
//  Created by Jakov Juric on 06/09/2019.
//  Copyright © 2019 Jakov Juric. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    // MARK: - ViewModel
    var viewModel: LoginViewModel!
    // MARK: - Views, lazy loading
    lazy var emailField: CustomFieldView = {
       let login = CustomFieldView()
        login.translatesAutoresizingMaskIntoConstraints = false
        login.configureFor(type: .email)
        login.nextInput = passwordField
        scrollView.addSubview(login)
        return login
    }()
    lazy var passwordField: CustomFieldView = {
       let password = CustomFieldView()
        password.configureFor(type: .password)
        scrollView.addSubview(password)
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
        btn.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        scrollView.addSubview(btn)
        return btn
    }()
    lazy var registerLabel1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Quicksand-Regular", size: 12)
        label.textColor = .appPurple
        label.text = "Nemaš račun? "
        registerContainer.addSubview(label)
        return label
    }()
    lazy var registerLabel2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Quicksand-Medium", size: 12)
        label.textColor = .appPurple
        label.text = "Registriraj se"
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(registerTapped)))
        registerContainer.addSubview(label)
        return label
    }()
    lazy var registerContainer: UIView = {
       let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .white
        scrollView.addSubview(container)
        return container
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCallbacks()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func setupConstraints() {
        // Scroll view setup
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.contentSize.height = 647
        // Views setup
        emailField.anchor(top: (loginLabel.bottomAnchor, 40), leading: (view.leadingAnchor, 20), trailing: (view.trailingAnchor, 20), size: CGSize(width: 0, height: 52))
        passwordField.anchor(top: (emailField.bottomAnchor, 0), leading: (view.leadingAnchor, 20), trailing: (view.trailingAnchor, 20), size: CGSize(width: 0, height: 52))
        loginButton.anchor(top: (passwordField.bottomAnchor, 90), leading: (view.leadingAnchor, 20), trailing: (view.trailingAnchor, 20), size: CGSize(width: 315, height: 62))
        registerContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerContainer.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 53).isActive = true
        registerContainer.heightAnchor.constraint(equalToConstant: 15).isActive = true
        registerLabel1.anchor(top: (registerContainer.topAnchor, 0), bottom: (registerContainer.bottomAnchor, 0), leading: (registerContainer.leadingAnchor, 0), trailing: (registerLabel2.leadingAnchor, 0), size: CGSize(width: 0, height: 15))
        registerLabel2.anchor(top: (registerContainer.topAnchor, 0), bottom: (registerContainer.bottomAnchor, 0), leading: (registerLabel1.trailingAnchor, 0), trailing: (registerContainer.trailingAnchor, 0), size: CGSize(width: 0, height: 15))
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
            guard let password = self?.passwordField.textField.text else { return }
            guard let passwordValid = self?.isPasswordValid(password) else { return }
            if !passwordValid {
                //show password error label
                print("Password not valid")
            }
        }
        emailField.onEndEditing = { [weak self] in
            guard let email = self?.emailField.textField.text else { return }
            guard let emailValid = self?.isEmailValid(email) else { return }
            if !emailValid {
                //show email error label
                print("E-mail not valid")
            }
        }
        
    }
    
    @objc func loginTapped() {
        // Check if email & password field are valid, if so try to login through Firebase
    }
    
    @objc func registerTapped() {
        viewModel.showRegistration()
    }
}

extension LoginViewController {
    // Email and Password validation
    func isEmailValid(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isPasswordValid(_ password: String) -> Bool {
        if password.count >= 6 {
            return true
        } else {
            return false
        }
    }
    
    private func shouldEnableLogin() -> Bool {
        if !(passwordField.textField.text?.isEmpty)!, !(emailField.textField.text?.isEmpty)! {
            return true
        } else {
            return false
        }
    }
}


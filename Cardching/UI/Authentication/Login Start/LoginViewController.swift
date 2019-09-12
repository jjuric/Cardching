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
    lazy var errorLabel: UILabel = {
        let error = UILabel()
        error.translatesAutoresizingMaskIntoConstraints = false
        error.font = UIFont(name: "Roboto-Light", size: 12)
        error.textColor = .redError
        error.numberOfLines = 0
        error.isHidden = true
        error.textAlignment = .center
        scrollView.addSubview(error)
        return error
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
        errorLabel.anchor(top: (passwordField.bottomAnchor, 10), leading: (view.leadingAnchor, 20), trailing: (view.trailingAnchor, 20))
        loginButton.anchor(top: (passwordField.bottomAnchor, 90), leading: (view.leadingAnchor, 20), trailing: (view.trailingAnchor, 20), size: CGSize(width: 315, height: 62))
        registerContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerContainer.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 53).isActive = true
        registerContainer.heightAnchor.constraint(equalToConstant: 15).isActive = true
        registerLabel1.anchor(top: (registerContainer.topAnchor, 0), bottom: (registerContainer.bottomAnchor, 0), leading: (registerContainer.leadingAnchor, 0), trailing: (registerLabel2.leadingAnchor, 0), size: CGSize(width: 0, height: 15))
        registerLabel2.anchor(top: (registerContainer.topAnchor, 0), bottom: (registerContainer.bottomAnchor, 0), leading: (registerLabel1.trailingAnchor, 0), trailing: (registerContainer.trailingAnchor, 0), size: CGSize(width: 0, height: 15))
    }
    
    private func addCallbacks() {
        emailField.onBeganEditing = { [weak self] in
            self?.canEnableLogIn()
        }
        passwordField.onBeganEditing = { [weak self] in
            self?.canEnableLogIn()

        }
        passwordField.onEndEditing = { [weak self] in
            self?.canEnableLogIn()

        }
        emailField.onEndEditing = { [weak self] in
            self?.canEnableLogIn()
        }
        viewModel.onErrorLogIn = { [weak self] error in
            self?.errorLabel.text = error
            self?.errorLabel.isHidden = false
        }
    }
    
    @objc func loginTapped() {
        // Check if email & password field are valid, if so try to login through Firebase
        errorLabel.isHidden = true
        guard let email = emailField.textField.text, let password = passwordField.textField.text, !email.isEmpty, !password.isEmpty else {
            errorLabel.text = "Popunite sva polja"
            errorLabel.isHidden = false
            return
        }
        viewModel.login(withEmail: email, password: password)
    }
    
    @objc func registerTapped() {
        viewModel.showRegistration()
    }
}

extension LoginViewController {
    private func canEnableLogIn(){
        if !(passwordField.textField.text?.isEmpty)!, !(emailField.textField.text?.isEmpty)! {
            loginButton.isEnabled = true
            loginButton.backgroundColor = .appPurple
        } else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = .gray
        }
    }
}


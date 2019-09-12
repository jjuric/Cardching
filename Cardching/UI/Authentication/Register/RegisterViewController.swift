//
//  RegisterViewController.swift
//  Cardching
//
//  Created by Jakov Juric on 09/09/2019.
//  Copyright © 2019 Jakov Juric. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var registerLabel: UILabel!
    // MARK: - ViewModel
    var viewModel: RegisterViewModel!
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
        password.nextInput = repeatPasswordField
        scrollView.addSubview(password)
        return password
    }()
    lazy var repeatPasswordField: CustomFieldView = {
       let password = CustomFieldView()
        password.configureFor(type: .password)
        scrollView.addSubview(password)
        return password
    }()
    lazy var registerButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Registriraj se", for: .normal)
        btn.titleLabel?.textColor = .white
        btn.titleLabel?.font = UIFont(name: "Quicksand-Bold", size: 18)
        btn.layer.cornerRadius = 30
        btn.backgroundColor = .appPurple
        btn.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        scrollView.addSubview(btn)
        return btn
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
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func addCallbacks() {
        viewModel.onError = { [weak self] error in
            self?.errorLabel.text = error
            self?.errorLabel.isHidden = false
        }
    }
    
    private func setupConstraints() {
        // Scroll view setup
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.contentSize.height = 647
        // Views setup
        emailField.anchor(top: (registerLabel.bottomAnchor, 40), leading: (view.leadingAnchor, 20), trailing: (view.trailingAnchor, 20), size: CGSize(width: 0, height: 52))
        passwordField.anchor(top: (emailField.bottomAnchor, 0), leading: (view.leadingAnchor, 20), trailing: (view.trailingAnchor, 20), size: CGSize(width: 0, height: 52))
        repeatPasswordField.anchor(top: (passwordField.bottomAnchor, 0), leading: (view.leadingAnchor, 20), trailing: (view.trailingAnchor, 20), size: CGSize(width: 0, height: 52))
        errorLabel.anchor(top: (repeatPasswordField.bottomAnchor, 10), leading: (view.leadingAnchor, 20), trailing: (view.trailingAnchor, 20))
        registerButton.anchor(top: (repeatPasswordField.bottomAnchor, 90), leading: (view.leadingAnchor, 20), trailing: (view.trailingAnchor, 20), size: CGSize(width: 315, height: 62))
    }
    
    @objc func registerTapped() {
        errorLabel.isHidden = true
        guard let email = emailField.textField.text, let password = passwordField.textField.text, let repeatedPass = repeatPasswordField.textField.text, !email.isEmpty, !password.isEmpty, !repeatedPass.isEmpty else {
            errorLabel.text = "Popunite sva polja"
            errorLabel.isHidden = false
            return
        }
        viewModel.register(with: email, password: password, repeatedPassword: repeatedPass)
    }
}

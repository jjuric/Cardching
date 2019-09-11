//
//  AuthenticationCoordinator.swift
//  Cardching
//
//  Created by Jakov Juric on 11/09/2019.
//  Copyright © 2019 Jakov Juric. All rights reserved.
//

import UIKit

class AuthenticationCoordinator: Coordinator {
    
    private var navigationController = UINavigationController()
    private var parentCoordinator: Coordinator!
    
    func start() -> UIViewController {
        return showLogin()
    }
    
    private func showLogin() -> UIViewController {
        let storyboard = UIStoryboard(name: "LoginViewController", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        let loginVM = LoginViewModel()
        
        loginVC.viewModel = loginVM
        
        loginVM.onShowRegistration = { [weak self] in
            self?.showRegistration()
        }
        loginVM.onLoggedIn = { [weak self] in
            self?.showCards()
        }
        
        navigationController.setViewControllers([loginVC], animated: false)
        return navigationController
    }
    
    private func showRegistration() {
        let storyboard = UIStoryboard(name: "RegisterViewController", bundle: nil)
        let registerVC = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        let registerVM  = RegisterViewModel()
        
        registerVC.viewModel = registerVM
        
        registerVM.onRegister = { [weak self] in
            self?.showCards()
        }
        
        navigationController.pushViewController(registerVC, animated: true)
    }
    
    private func showCards() {
        guard let window = UIApplication.shared.windows.first else { return }
        parentCoordinator = CardsCoordinator()
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: { [weak self] in
            window.rootViewController = self?.parentCoordinator.start()
        }, completion: nil)
    }
}

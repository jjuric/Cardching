//
//  MainCoordinator.swift
//  Cardching
//
//  Created by Jakov Juric on 09/09/2019.
//  Copyright © 2019 Jakov Juric. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    
    private var navigationController = UINavigationController()
    private var isUserLoggedIn: Bool = false
    
    func start() -> UIViewController {
        if isUserLoggedIn {
            return showCards()
        } else {
            return showLogin()
        }
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
            let _ = self?.showCards()
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
            let _ = self?.showCards()
        }
        
        navigationController.pushViewController(registerVC, animated: true)
    }
    
    private func showCards() -> UIViewController {
        let storyboard = UIStoryboard(name: "CardsViewController", bundle: nil)
        let cardsVC = storyboard.instantiateViewController(withIdentifier: "CardsViewController") as! CardsViewController
        let cardsVM = CardsViewModel()
        
        cardsVC.viewModel = cardsVM
        
        cardsVM.onShowBarcode = { [weak self] in
            // show barcode vc
        }
        cardsVM.onShowCardDetails = { [weak self] card in
            // show card details vc
        }
        cardsVM.onAddNewCard = { [weak self] in
            // show new card vc
        }
        
        navigationController.setViewControllers([cardsVC], animated: true)
        return navigationController
    }
}

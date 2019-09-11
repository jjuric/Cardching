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
    private var childCoordinators: [Coordinator] = [AuthenticationCoordinator(), CardsCoordinator()]
    
    func start() -> UIViewController {
        if isUserLoggedIn {
            return childCoordinators[1].start()
        } else {
            return childCoordinators[0].start()
        }
    }
}

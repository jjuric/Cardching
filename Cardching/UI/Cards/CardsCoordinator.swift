//
//  CardsCoordinator.swift
//  Cardching
//
//  Created by Jakov Juric on 11/09/2019.
//  Copyright © 2019 Jakov Juric. All rights reserved.
//

import UIKit

class CardsCoordinator: Coordinator {
    
    private var navigationController = UINavigationController()
    private var parentCoordinator: Coordinator!
    
    func start() -> UIViewController {
        return showCards()
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
            let storyboard = UIStoryboard(name: "DetailCardViewController", bundle: nil)
            let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailCardViewController") as! DetailCardViewController
            let detailVM = DetailCardViewModel()
            
            detailVC.viewModel = detailVM
            detailVC.card = card
            
            self?.navigationController.pushViewController(detailVC, animated: true)
        }
        cardsVM.onAddNewCard = { [weak self] in
            let storyboard = UIStoryboard(name: "NewCardViewController", bundle: nil)
            let newVC = storyboard.instantiateViewController(withIdentifier: "NewCardViewController") as! NewCardViewController
            
            self?.navigationController.pushViewController(newVC, animated: true)
        }
        
        navigationController.setViewControllers([cardsVC], animated: true)
        return navigationController
    }
}

//
//  CardsViewModel.swift
//  Cardching
//
//  Created by Jakov Juric on 09/09/2019.
//  Copyright © 2019 Jakov Juric. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class CardsViewModel {
    
    // MARK: - Variables
    struct Card {
        var name: String
        var barcode: String
        var image: UIImage?
        var expiration: String
        
        init(name: String, barcode: String, expiration: String, image: UIImage) {
            self.name = name
            self.barcode = barcode
            self.image = image
            self.expiration = expiration
        }
        
        init(name: String, barcode: String, expiration: String) {
            self.name = name
            self.barcode = barcode
            self.image = UIImage(named: "cardPlaceholder")
            self.expiration = expiration
        }
    }
    
    
    var cards: [Card] = [Card(name: "Test kartica", barcode: "2131231231231", expiration: "12/05/1996")]
    
    // MARK: - Callbacks
    var onShowBarcode: (() -> Void)?
    var onShowCardDetails: ((Card) -> Void)?
    var onAddNewCard: (() -> Void)?
    var onError: (() -> Void)?
    var onSignedOut: (() -> Void)?
    
    // MARK: - Methods
    func showBarcode() {
        onShowBarcode?()
    }
    
    func showCardDetails(for cardIndex: Int) {
        onShowCardDetails?(cards[cardIndex])
    }
    
    func addNewCard() {
        onAddNewCard?()
    }
    
    func logOutUser() {
        do {
            try Auth.auth().signOut()
            onSignedOut?()
        } catch {
            onError?()
        }
    }
}

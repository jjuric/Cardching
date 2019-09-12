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
import Firebase

class CardsViewModel {
    
    enum ErrorType: String {
        case logoutError = "Problem pri odjavi korisnika, probajte ponovno."
        case collectionError = "Problem pri dohvaćanju podataka"
    }
    
    // MARK: - Variables
    var cards: [Card] = [Card(name: "myCard", barcode: "12342691337", expiration: "12/05/1996")]
    
    // MARK: - Callbacks
    var onShowBarcode: (() -> Void)?
    var onShowCardDetails: ((Card) -> Void)?
    var onAddNewCard: (() -> Void)?
    var onError: ((String) -> Void)?
    var onSignedOut: (() -> Void)?
    var onStateChanged: ((State) -> Void)?
    
    // States
    enum State {
        case initial
        case loading
        case loaded
        case empty
    }
    var state: State = .initial {
        didSet {
            onStateChanged?(state)
        }
    }
    
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
            onError?(ErrorType.logoutError.rawValue)
        }
    }
    
    func loadUserCards() {
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        state = .loading
        let cardCollection = db.collection("users").document("\(userUID)").collection("cards")
        
        cardCollection.getDocuments { [weak self] (snapshot, error) in
            if let _ = error {
                self?.onError?(ErrorType.collectionError.rawValue)
                self?.state = .initial
            } else if let snapshot = snapshot {
                let cards = snapshot.documents
                if cards.isEmpty {
                    self?.state = .empty
                    return
                }
                self?.cards = []
                for card in cards {
                    let name = card.data()["name"] as! String
                    let barcode = card.data()["barcode"] as! String
                    let expiration = card.data()["expiration"] as! String
                    let imageData = card.data()["imageData"] as! Data
                    guard let image = UIImage(data: imageData) else { return }
                    let item = Card(name: name, barcode: barcode, expiration: expiration, image: image)
                    self?.cards.append(item)
                }
                self?.state = .loaded
            }
        }
    }
}

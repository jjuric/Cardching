//
//  DetailCardViewModel.swift
//  Cardching
//
//  Created by Jakov Juric on 10/09/2019.
//  Copyright © 2019 Jakov Juric. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

class DetailCardViewModel {
    
    // MARK: - Callbacks
    var onShowBarcode: ((String) -> Void)?
    var onDelete: (() -> Void)?
    var onError: ((String) -> Void)?
    var onEdited: (() -> Void)?
    
    //MARK: - Methods
    func deleteCard(_ card: Card) {
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        let cardID = card.name
        let db = Firestore.firestore()
        
        db.collection("users/\(userUID)/cards").document("\(cardID)").delete { [weak self] (error) in
            if let _ = error {
                self?.onError?("Pogreška pri brisanju kartice.")
            } else {
                self?.onDelete?()
            }
        }
    }
    
    private func deleteCard(_ id: String) {
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        
        db.collection("users/\(userUID)/cards").document("\(id)").delete { [weak self] (error) in
            if let _ = error {
                self?.onError?("Pogreška pri uređivanju stare kartice.")
            }
        }
    }
    
    func editCard(withID cardID: String, _ card: Card) {
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        guard let imageData = card.image!.jpegData(compressionQuality: 0.5) else { return }
        let newID = card.name
        let db = Firestore.firestore()
        
        deleteCard(cardID)
        
        db.collection("users/\(userUID)/cards").document("\(newID)").setData([
            "name" : card.name,
            "barcode" : card.barcode,
            "expiration" : card.expiration,
            "imageData" : imageData
        ]) { [weak self] (error) in
            if let _ = error {
                self?.onError?("Kartica se trenutno ne može urediti.")
                return
            } else {
                self?.onEdited?()
            }
        }
    }
    
    func showBarcode(_ barcode: String) {
        onShowBarcode?(barcode)
    }
}

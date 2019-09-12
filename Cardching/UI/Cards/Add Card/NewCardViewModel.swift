//
//  NewCardViewModel.swift
//  Cardching
//
//  Created by Jakov Juric on 10/09/2019.
//  Copyright © 2019 Jakov Juric. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class NewCardViewModel {
    
    // MARK: - Callbacks
    var onError: (() -> Void)?
    var onCardSaved: ((Card) -> Void)?
    
    func saveCard(name: String, barcode: String, image: UIImage, expiration: String) {
        let db = Firestore.firestore()
        let card = Card(name: name, barcode: barcode, expiration: expiration, image: image)
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        db.collection("users/\(userUID)/cards").addDocument(data: [
            "name" : name,
            "barcode" : barcode,
            "expiration" : expiration,
            "imageData" : imageData
        ]) { [weak self] (error) in
            if error != nil {
                self?.onError?()
            } else {
                self?.onCardSaved?(card)
            }
        }
    }
    
}

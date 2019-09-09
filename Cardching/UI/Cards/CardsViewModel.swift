//
//  CardsViewModel.swift
//  Cardching
//
//  Created by Jakov Juric on 09/09/2019.
//  Copyright © 2019 Jakov Juric. All rights reserved.
//

import Foundation
import UIKit

class CardsViewModel {
    // MARK: - Variables
    struct Card {
        var name: String
        var barcode: String
        var image: UIImage?
        
        init(name: String, barcode: String, image: UIImage) {
            self.name = name
            self.barcode = barcode
            self.image = image
        }
        
        init(name: String, barcode: String) {
            self.name = name
            self.barcode = barcode
            self.image = UIImage(named: "cardPlaceholder")
        }
    }
    var cards: [Card] = [Card(name: "Test kartica", barcode: "2131231231231")]
    
    // MARK: - Callbacks
    var onShowBarcode: (() -> Void)?
    
    
    
    func showBarcode() {
        onShowBarcode?()
    }
}

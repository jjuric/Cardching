//
//  Card.swift
//  Cardching
//
//  Created by Jakov Juric on 12/09/2019.
//  Copyright © 2019 Jakov Juric. All rights reserved.
//

import Foundation
import UIKit

class Card {
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

//
//  DetailCardViewModel.swift
//  Cardching
//
//  Created by Jakov Juric on 10/09/2019.
//  Copyright © 2019 Jakov Juric. All rights reserved.
//

import Foundation

class DetailCardViewModel {
    
    // MARK: - Callbacks
    var onShowBarcode: (() -> Void)?
    
    
    //MARK: - Methods
    func deleteCard() {
        // open modal for confirmation and handle deletion of card
    }
    
    func editCard() {
        // open modal to change name, date, image
    }
    
    func showBarcode() {
        onShowBarcode?()
    }
}

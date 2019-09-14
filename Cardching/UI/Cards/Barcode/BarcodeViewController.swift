//
//  BarcodeViewController.swift
//  Cardching
//
//  Created by Jakov Juric on 09/09/2019.
//  Copyright © 2019 Jakov Juric. All rights reserved.
//

import UIKit

class BarcodeViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var barcodeImageView: UIImageView!
    
    lazy var barcodeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 25)
        label.transform = CGAffineTransform(rotationAngle: .pi/2)
        view.addSubview(label)
        return label
    }()
    
    var barcode: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        setupBarcode(from: barcode)
    }
    
    func setupBarcode(from string: String) {
        guard let image = UIImage(barcode: string) else { return }
        let rotatedImg = image.rotate(radians: .pi/2)
        
        barcodeImageView.image = rotatedImg
        barcodeLabel.text = string
    }
    
    func style() {
        barcodeLabel.transform = CGAffineTransform(rotationAngle: .pi/2)
        barcodeLabel.numberOfLines = 1
        barcodeLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        barcodeLabel.frame.origin.x = barcodeImageView.frame.origin.x - 10
    }
}

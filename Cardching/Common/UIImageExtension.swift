//
//  UIImageExtension.swift
//  Cardching
//
//  Created by Jakov Juric on 14/09/2019.
//  Copyright © 2019 Jakov Juric. All rights reserved.
//

import UIKit

extension UIImage {
    // Barcode image generation
    convenience init?(barcode: String) {
        let data = barcode.data(using: .ascii)
        guard let filter = CIFilter(name: "CICode128BarcodeGenerator") else { return nil }
        filter.setValue(data, forKey: "inputMessage")
//        filter.setValue(20, forKey: "inputQuietSpace")
        guard let ciImage = filter.outputImage else { return nil }
        self.init(ciImage: ciImage)
    }
    
    // UIImage rotation without view
    func rotate(radians: CGFloat) -> UIImage {
        let rotatedSize = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
            .integral.size
        UIGraphicsBeginImageContext(rotatedSize)
        if let context = UIGraphicsGetCurrentContext() {
            let origin = CGPoint(x: rotatedSize.width / 2.0,
                                 y: rotatedSize.height / 2.0)
            context.translateBy(x: origin.x, y: origin.y)
            context.rotate(by: radians)
            draw(in: CGRect(x: -origin.y, y: -origin.x,
                            width: size.width, height: size.height))
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return rotatedImage ?? self
        }
        
        return self
    }
}

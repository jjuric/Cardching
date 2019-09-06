//
//  AnchorExtensions.swift
//  Cardching
//
//  Created by Jakov Juric on 06/09/2019.
//  Copyright © 2019 Jakov Juric. All rights reserved.
//

import UIKit

extension UIView {
    func anchor(top: (NSLayoutYAxisAnchor, CGFloat)? = nil, bottom: (NSLayoutYAxisAnchor, CGFloat)? = nil, leading: (NSLayoutXAxisAnchor, CGFloat)? = nil, trailing: (NSLayoutXAxisAnchor, CGFloat)? = nil, size: CGSize = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top.0, constant: top.1).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom.0, constant: -bottom.1).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading.0, constant: leading.1).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing.0, constant: -trailing.1).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
    }
}

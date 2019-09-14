//
//  NoInternetView.swift
//  Cardching
//
//  Created by Jakov Juric on 14/09/2019.
//  Copyright © 2019 Jakov Juric. All rights reserved.
//

import UIKit

class NoInternetView: UIView {
    
    lazy var icon: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        imgView.image = UIImage(named: "noWifi")
        addSubview(imgView)
        return imgView
    }()
    lazy var emptyText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .formGray
        label.font = UIFont(name: "Quicksand-Medium", size: 14)
        label.text = "Nemate pristup internetu. Kada se spojite kliknite bilo gdje na ekran za ponovno učitavanje"
        label.numberOfLines = 0
        label.textAlignment = .center
        addSubview(label)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        icon.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        icon.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor, constant: -100).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 300).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        emptyText.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        emptyText.anchor(top: (icon.bottomAnchor, 20), leading: (leadingAnchor, 60), trailing: (trailingAnchor, 60))
    }
}

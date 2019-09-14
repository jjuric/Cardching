//
//  DeleteView.swift
//  Cardching
//
//  Created by Jakov Juric on 14/09/2019.
//  Copyright © 2019 Jakov Juric. All rights reserved.
//

import UIKit

class DeleteView: UIView {
    
    lazy var deleteLabel: UILabel = {
        let deleteLabel = UILabel()
        deleteLabel.font = UIFont(name: "Quicksand-Medium", size: 20)
        deleteLabel.textColor = .appPurple
        deleteLabel.text = "Želite li obrisati karticu?"
        deleteLabel.numberOfLines = 0
        addSubview(deleteLabel)
        return deleteLabel
    }()
    lazy var confirmButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Da", for: .normal)
        addSubview(btn)
        return btn
    }()
    lazy var cancelButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Ne", for: .normal)
        addSubview(btn)
        return btn
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
        deleteLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        deleteLabel.anchor(top: (topAnchor, 20), leading: (leadingAnchor, 20), trailing: (trailingAnchor, 20))
        
        confirmButton.anchor(top: (deleteLabel.bottomAnchor, 20), bottom: (bottomAnchor, 20), leading: (leadingAnchor, 30))
        cancelButton.anchor(top: (deleteLabel.bottomAnchor, 20), bottom: (bottomAnchor, 20), trailing: (trailingAnchor, 30))
    }
}

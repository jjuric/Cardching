//
//  EditView.swift
//  Cardching
//
//  Created by Jakov Juric on 14/09/2019.
//  Copyright © 2019 Jakov Juric. All rights reserved.
//

import UIKit

class EditView: UIView {
    
    lazy var cardImage: UIImageView = {
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.layer.cornerRadius = imgView.frame.width / 2
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        addSubview(imgView)
        return imgView
    }()
    lazy var nameTextField: TextField = {
        let txtField = TextField()
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.placeholder = "Ime kartice"
        txtField.font = UIFont(name: "Roboto-Light", size: 14)
        txtField.borderStyle = .roundedRect
        txtField.autocorrectionType = .no
        txtField.delegate = self
        addSubview(txtField)
        return txtField
    }()
    lazy var barcodeTextField: TextField = {
        let txtField = TextField()
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.placeholder = "Barkod"
        txtField.font = UIFont(name: "Roboto-Light", size: 14)
        txtField.borderStyle = .roundedRect
        txtField.autocorrectionType = .no
        txtField.delegate = self
        addSubview(txtField)
        return txtField
    }()
    lazy var categoryTextField: TextField = {
        let txtField = TextField()
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.placeholder = "Kategorija"
        txtField.font = UIFont(name: "Roboto-Light", size: 14)
        txtField.borderStyle = .roundedRect
        txtField.autocorrectionType = .no
        txtField.delegate = self
        addSubview(txtField)
        return txtField
    }()
    lazy var confirmButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Promjeni", for: .normal)
        addSubview(btn)
        return btn
    }()
    lazy var cancelButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Odustani", for: .normal)
        addSubview(btn)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        cardImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        cardImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        cardImage.anchor(size: CGSize(width: 60, height: 60))
        nameTextField.anchor(top: (cardImage.bottomAnchor, 0), bottom: (barcodeTextField.topAnchor, 0), leading: (leadingAnchor, 0), trailing: (trailingAnchor, 0), size: CGSize(width: 0, height: 30))
        barcodeTextField.anchor(top: (nameTextField.bottomAnchor, 0), bottom: (categoryTextField.topAnchor, 0), leading: (leadingAnchor, 0), trailing: (trailingAnchor, 0), size: CGSize(width: 0, height: 30))
        categoryTextField.anchor(top: (barcodeTextField.bottomAnchor, 0), leading: (leadingAnchor, 0), trailing: (trailingAnchor, 0), size: CGSize(width: 0, height: 30))
        confirmButton.anchor(top: (categoryTextField.bottomAnchor, 5), bottom: (bottomAnchor, 5), leading: (leadingAnchor, 20))
        cancelButton.anchor(top: (categoryTextField.bottomAnchor, 5), bottom: (bottomAnchor, 5), trailing: (trailingAnchor, 20))
    }
    
}

extension EditView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}

//
//  NewCardViewController.swift
//  Cardching
//
//  Created by Jakov Juric on 09/09/2019.
//  Copyright © 2019 Jakov Juric. All rights reserved.
//

import UIKit

class NewCardViewController: UIViewController {

    @IBOutlet weak var addCardLabel: UILabel!
    @IBOutlet weak var cardImage: UIImageView!
    
    var viewModel: NewCardViewModel!
    
    lazy var iamgePicker: UIImagePickerController = {
       let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        return picker
    }()
    lazy var cardNameField: CustomFieldView = {
       let field = CustomFieldView()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.configureFor(type: .cardName)
        view.addSubview(field)
        return field
    }()
    lazy var expirationField: CustomFieldView = {
        let field = CustomFieldView()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.configureFor(type: .expiration)
        field.textField.inputView = UIDatePicker()
        view.addSubview(field)
        return field
    }()
    lazy var categoryField: CustomFieldView = {
        let field = CustomFieldView()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.configureFor(type: .category)
        view.addSubview(field)
        return field
    }()
    lazy var barcodeField: CustomFieldView = {
        let field = CustomFieldView()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.configureFor(type: .barcode)
        view.addSubview(field)
        return field
    }()
    lazy var saveCardButton: UIButton = {
       let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Spremi karticu", for: .normal)
        btn.backgroundColor = .appPurple
        btn.layer.cornerRadius = 30
        btn.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        view.addSubview(btn)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCallbacks()
        setupConstraints()
    }
    
    private func addCallbacks() {
        expirationField.onShowCalendar = {
            print("show calendaererearar")
        }
    }
    
    private func setupConstraints() {
        cardNameField.anchor(top: (addCardLabel.bottomAnchor, 25), leading: (view.leadingAnchor, 20), trailing: (view.trailingAnchor, 20), size: CGSize(width: 0, height: 52))
        expirationField.anchor(top: (cardNameField.bottomAnchor, 0), leading: (view.leadingAnchor, 20), trailing: (view.trailingAnchor, 20), size: CGSize(width: 0, height: 52))
        categoryField.anchor(top: (expirationField.bottomAnchor, 0), leading: (view.leadingAnchor, 20), trailing: (view.trailingAnchor, 20), size: CGSize(width: 0, height: 52))
        barcodeField.anchor(top: (categoryField.bottomAnchor, 0), leading: (view.leadingAnchor, 20), trailing: (view.trailingAnchor, 20), size: CGSize(width: 0, height: 52))
        saveCardButton.anchor(top: (barcodeField.bottomAnchor, 60), size: CGSize(width: 315, height: 62))
        saveCardButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    @objc func saveTapped() {
        guard let name = cardNameField.textField.text, let barcode = barcodeField.textField.text, let expiration = expirationField.textField.text else { return }
        var image = UIImage(named: "cardPlaceholder")
        if cardImage.image != UIImage(named: "addImagePlaceholder") {
            image = cardImage.image
        }
        viewModel.saveCard(name: name, barcode: barcode, image: image, expiration: expiration)
    }
}

extension NewCardViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        cardImage.image = image
        dismiss(animated: true, completion: nil)
    }
}

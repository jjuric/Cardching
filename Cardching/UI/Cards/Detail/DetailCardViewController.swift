//
//  DetailCardViewController.swift
//  Cardching
//
//  Created by Jakov Juric on 09/09/2019.
//  Copyright © 2019 Jakov Juric. All rights reserved.
//

import UIKit

class DetailCardViewController: UIViewController {

    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardName: UILabel!
    @IBOutlet weak var cardExpiration: UILabel!
    @IBOutlet weak var viewMask: UIView!
    
    var viewModel: DetailCardViewModel!
    var card: Card!
    var deleteViewConstraint: NSLayoutConstraint!
    var editViewConstraint: NSLayoutConstraint!
    
    lazy var showBarcodeButton: UIButton = {
       let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Prikaži barkod", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Quicksand-Bold", size: 18)
        btn.layer.cornerRadius = 30
        btn.backgroundColor = .appPurple
        btn.addTarget(self, action: #selector(showBarcodeTapped), for: .touchUpInside)
        view.addSubview(btn)
        return btn
    }()
    lazy var controlStack: UIStackView = {
       let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 55
        view.addSubview(stack)
        return stack
    }()
    lazy var editButton: UIButton = {
       let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        btn.layer.cornerRadius = btn.frame.width / 2
        btn.setImage(UIImage(named: "editCardBtn"), for: .normal)
        btn.addTarget(self, action: #selector(editTapped), for: .touchUpInside)
        controlStack.addSubview(btn)
        return btn
    }()
    lazy var deleteButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        btn.layer.cornerRadius = btn.frame.width / 2
        btn.setImage(UIImage(named: "deleteCardBtn"), for: .normal)
        btn.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
        controlStack.addSubview(btn)
        return btn
    }()
    lazy var deleteView: DeleteView = {
        let del = DeleteView()
        del.translatesAutoresizingMaskIntoConstraints = false
        del.backgroundColor = .white
        del.layer.cornerRadius = 10
        del.confirmButton.addTarget(self, action: #selector(confirmDeleteTapped), for: .touchUpInside)
        del.cancelButton.addTarget(self, action: #selector(cancelDeleteTapped), for: .touchUpInside)
        view.addSubview(del)
        return del
    }()
    lazy var editView: EditView = {
        let edit = EditView()
        edit.translatesAutoresizingMaskIntoConstraints = false
        edit.backgroundColor = .white
        edit.layer.cornerRadius = 10
        edit.confirmButton.addTarget(self, action: #selector(confirmEditTapped), for: .touchUpInside)
        edit.cancelButton.addTarget(self, action: #selector(cancelEditTapped), for: .touchUpInside)
        edit.cardImage.image = card.image
        edit.cardImage.isUserInteractionEnabled = true
        edit.cardImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(editImageTapped)))
        view.addSubview(edit)
        return edit
    }()
    lazy var imagePicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCallbacks()
        setupCard()
        setupConstraints()
        style()
    }
    
    func addCallbacks() {
        viewModel.onError = { [weak self] error in
            self?.showAlert(title: "Ups!", message: error)
        }
        viewModel.onDelete = { [weak self] in
            self?.showAlertPopToRoot(title: "Uspjeh!", message: "Kartica je obrisana iz vaše kolekcije.")
        }
        viewModel.onEdited = { [weak self] in
            self?.showAlertPopToRoot(title: "Uspjeh!", message: "Kartica je uređena.")
        }
    }
    
    func setupConstraints() {
        showBarcodeButton.anchor(top: (cardExpiration.bottomAnchor, 50), leading: (view.leadingAnchor, 30), trailing: (view.trailingAnchor, 30), size: CGSize(width: 315, height: 62))
        controlStack.anchor(top: (showBarcodeButton.bottomAnchor, 50), size: CGSize(width: 195, height: 70))
        controlStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        editButton.anchor(top: (controlStack.topAnchor, 0), bottom: (controlStack.bottomAnchor, 0), leading: (controlStack.leadingAnchor, 0), size: CGSize(width: 70, height: 70))
        deleteButton.anchor(top: (controlStack.topAnchor, 0), bottom: (controlStack.bottomAnchor, 0), trailing: (controlStack.trailingAnchor, 0), size: CGSize(width: 70, height: 70))
        // Modals
        deleteView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        deleteViewConstraint = deleteView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant:  1000)
        deleteViewConstraint.isActive = true
        deleteView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        deleteView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        editView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        editViewConstraint = editView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 1000)
        editViewConstraint.isActive = true
        editView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        editView.widthAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    func setupCard() {
        cardName.text = card.name
        cardImage.image = card.image
        cardExpiration.text = "Vrijedi do: \(card.expiration)"
    }
    
    func style() {
        cardImage.layer.cornerRadius = cardImage.frame.width / 2
        viewMask.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }
    
    @objc func deleteTapped() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.viewMask.isHidden = false
            self?.deleteViewConstraint.constant = 0
            self?.view.layoutIfNeeded()
        }
    }
    
    @objc func editTapped() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.viewMask.isHidden = false
            self?.editViewConstraint.constant = 0
            self?.view.layoutIfNeeded()
        }
    }
    
    @objc func showBarcodeTapped() {
        viewModel.showBarcode(card.barcode)
    }
    
    @objc func confirmDeleteTapped() {
        viewModel.deleteCard(card)
    }
    
    @objc func cancelDeleteTapped() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.viewMask.isHidden = true
            self?.deleteViewConstraint.constant = 1000
            self?.view.layoutIfNeeded()
        }
    }
    
    @objc func confirmEditTapped() {
        let cardID = card.name
        if let name = editView.nameTextField.text, !name.isEmpty {
            card.name = name
        }
        if let barcode = editView.barcodeTextField.text, !barcode.isEmpty {
            card.barcode = barcode
        }
        if let image = editView.cardImage.image, image != card.image {
            card.image = image
        }
        
        viewModel.editCard(withID: cardID, card)
    }
    
    @objc func cancelEditTapped() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.viewMask.isHidden = true
            self?.editViewConstraint.constant = 1000
            self?.view.layoutIfNeeded()
        }
    }
    
    @objc func editImageTapped() {
        present(imagePicker, animated: true)
    }
}

extension DetailCardViewController {
    // Alerts
    private func showAlert(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true)
    }
    
    private func showAlertPopToRoot(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            self?.navigationController?.popToRootViewController(animated: true)
        }))
        present(ac, animated: true)
    }
}

extension DetailCardViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        cardImage.image = image
        editView.cardImage.image = image
        dismiss(animated: true, completion: nil)
    }
}

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
    
    var viewModel: DetailCardViewModel!
    var card: CardsViewModel.Card!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCard()
        setupConstraints()
    }
    
    func setupConstraints() {
        showBarcodeButton.anchor(top: (cardExpiration.bottomAnchor, 50), leading: (view.leadingAnchor, 30), trailing: (view.trailingAnchor, 30), size: CGSize(width: 315, height: 62))
        controlStack.anchor(top: (showBarcodeButton.bottomAnchor, 50), size: CGSize(width: 195, height: 70))
        controlStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        editButton.anchor(top: (controlStack.topAnchor, 0), bottom: (controlStack.bottomAnchor, 0), leading: (controlStack.leadingAnchor, 0), size: CGSize(width: 70, height: 70))
        deleteButton.anchor(top: (controlStack.topAnchor, 0), bottom: (controlStack.bottomAnchor, 0), trailing: (controlStack.trailingAnchor, 0), size: CGSize(width: 70, height: 70))
    }
    
    func setupCard() {
        cardName.text = card.name
        cardImage.image = card.image
        cardExpiration.text = "Vrijedi do: \(card.expiration)"
    }
    
    @objc func deleteTapped() {
        viewModel.deleteCard()
    }
    
    @objc func editTapped() {
        viewModel.editCard()
    }
    
    @objc func showBarcodeTapped() {
        viewModel.showBarcode()
    }
}

//
//  CardTableViewCell.swift
//  Cardching
//
//  Created by Jakov Juric on 09/09/2019.
//  Copyright © 2019 Jakov Juric. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell {
    
    var viewModel: CardsViewModel!
    var card: CardsViewModel.Card! {
        didSet {
            cardPicture.image = card.image
            cardName.text = card.name
            cardBarcode.text = "Šifra barkoda: \(card.barcode)"
        }
    }
    // MARK: - Cell views
    lazy var cardPicture: UIImageView = {
       let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFill
        imgView.image = UIImage(named: "cardPlaceholder")
        imgView.layer.cornerRadius = imgView.frame.width / 2
        cardInfoStack.addSubview(imgView)
        return imgView
    }()
    lazy var cardName: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = UIFont(name: "Roboto-Medium", size: 15)
        name.textColor = .appPurple
        addSubview(name)
        return name
    }()
    lazy var cardBarcode: UILabel = {
       let barcode = UILabel()
        barcode.translatesAutoresizingMaskIntoConstraints = false
        barcode.font = UIFont(name: "Roboto-Regular", size: 12)
        barcode.textColor = .barcodeGray
        barcode.text = "Šifra barkoda: "
        cardInfoStack.addSubview(barcode)
        return barcode
    }()
    lazy var barcodeButton: UIButton = {
       let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "barcodeButton"), for: .normal)
        btn.addTarget(self, action: #selector(showBarcodeTapped), for: .touchUpInside)
        addSubview(btn)
        return btn
    }()
    lazy var cardInfoStack: UIStackView = {
       let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = UIStackView.Distribution.fillProportionally
        stack.spacing = 5
        addSubview(stack)
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        cardPicture.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        cardPicture.anchor(leading: (leadingAnchor, 25),  size: CGSize(width: 70, height: 70))
        cardInfoStack.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        cardInfoStack.anchor(leading: (cardPicture.trailingAnchor, 34), size: CGSize(width: 0, height: 41))
        cardName.anchor(top: (cardInfoStack.topAnchor, 0), bottom: (cardBarcode.topAnchor, 0), leading: (cardInfoStack.leadingAnchor, 0), trailing: (cardInfoStack.trailingAnchor, 0), size: CGSize(width: 0, height: 20))
        cardBarcode.anchor(top: (cardName.bottomAnchor, 0), bottom: (cardInfoStack.bottomAnchor, 0), leading: (cardInfoStack.leadingAnchor, 0), trailing: (cardInfoStack.trailingAnchor, 0), size: CGSize(width: 0, height: 16))
    }
    
    @objc func showBarcodeTapped() {
        viewModel.showBarcode()
    }
    
}

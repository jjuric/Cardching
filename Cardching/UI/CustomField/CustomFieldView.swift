//
//  CustomFieldView.swift
//  Cardching
//
//  Created by Jakov Juric on 06/09/2019.
//  Copyright © 2019 Jakov Juric. All rights reserved.
//

import UIKit

enum FieldType {
    case email
    case password
    case cardName
    case expiration
    case category
    case barcode
}

class CustomFieldView: UIView {
    //MARK: - Callbacks
    var onEndEditing: (() -> Void)?
    var onBeganEditing: (() -> Void)?
    var onShowCalendar: (() -> Void)?
    
    // MARK: - Views
    lazy var textField: TextField = {
       let field = TextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        addSubview(field)
        field.borderStyle = .none
        field.delegate = self
        field.textColor = .formGray
        field.font = UIFont(name: "Roboto-Light", size: 14)
        field.autocapitalizationType = .none
        field.returnKeyType = .done
        field.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        return field
    }()
    lazy var separator: UIView = {
       let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .appPurple
        addSubview(line)
        return line
    }()
    lazy var passwordButton: UIButton = {
       let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "showHidePass"), for: .normal)
        button.addTarget(self, action: #selector(showHideTapped), for: .touchUpInside)
        addSubview(button)
        return button
    }()
    lazy var calendarButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "calendarButton"), for: .normal)
        button.addTarget(self, action: #selector(showCalendarTapped), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFill
        addSubview(button)
        return button
    }()
    
    var nextInput: CustomFieldView? {
        didSet {
            textField.returnKeyType = .next
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var type: FieldType! {
        didSet {
            configureFor(type: type)
        }
    }
    
    func configureFor(type: FieldType) {
        switch type {
        case .email:
            textField.keyboardType = .emailAddress
            textField.isSecureTextEntry = false
            textField.placeholder = "E-mail"
        case .password:
            textField.keyboardType = .default
            textField.isSecureTextEntry = true
            textField.placeholder = "Lozinka"
            addHideShowButton()
        case .cardName:
            textField.keyboardType = .default
            textField.isSecureTextEntry = false
            textField.placeholder = "Ime kartice"
        case .expiration:
            textField.keyboardType = .default
            textField.isSecureTextEntry = false
            textField.placeholder = "Vrijedi do"
            addCalendarButton()
        case .barcode:
            textField.keyboardType = .default
            textField.isSecureTextEntry = false
            textField.placeholder = "Šifra barkoda"
        case .category:
            textField.keyboardType = .default
            textField.isSecureTextEntry = false
            textField.placeholder = "Kategorija (moda, hrana,...)"
        }
    }
    
    private func setupConstraints() {
        textField.anchor(top: (topAnchor, 0), bottom: (bottomAnchor, 1), leading: (leadingAnchor, 0), trailing: (trailingAnchor, 0), size: CGSize(width: 0, height: 50))
        separator.anchor(top: (textField.bottomAnchor, 0), bottom: (bottomAnchor, 0), leading: (leadingAnchor, 0), trailing: (trailingAnchor, 0), size: CGSize(width: 0, height: 1))
    }
    
    private func addHideShowButton() {
        passwordButton.anchor(top: (topAnchor, 10), bottom: (bottomAnchor, 10), trailing: (trailingAnchor, 5), size: CGSize(width: 24, height: 16.3))
    }
    
    private func addCalendarButton() {
        calendarButton.anchor(top: (topAnchor, 10), bottom: (bottomAnchor, 10), trailing: (trailingAnchor, 5), size: CGSize(width: 30, height: 30))
    }
    
    @objc func showHideTapped() {
        textField.isSecureTextEntry = !textField.isSecureTextEntry
    }
    
    @objc func textFieldChanged() {
        onBeganEditing?()
    }
    
    @objc func showCalendarTapped() {
        onShowCalendar?()
    }
    
}
extension CustomFieldView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let next = nextInput {
            next.textField.becomeFirstResponder()
        } else {
            textField.endEditing(true)
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        onEndEditing?()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        onBeganEditing?()
    }
}

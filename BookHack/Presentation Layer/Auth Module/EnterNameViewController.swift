//
//  EnterNameViewController.swift
//  Pokushats
//
//
//  Created by Сергей Зайцев on 21.03.2021.
//

import UIKit

final class EnterNameViewController: BaseEnterViewController {
    
    private let delegate: EnterNameDelegate
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.returnKeyType = .next
        textField.keyboardType = .default
        textField.backgroundColor = .clear
        textField.font = AppFonts.phoneNumber
        textField.textColor = AppColors.white
        textField.borderStyle = .none
        textField.attributedPlaceholder = NSAttributedString(string: AppTexts.AuthFlow.EnterName.namePlaceHolder,
                                                             attributes: [NSAttributedString.Key.foregroundColor: AppColors.white.withAlphaComponent(0.7)])
        textField.delegate = self
        return textField
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.nameError
        label.textColor = AppColors.white
        label.numberOfLines = 0
        label.textAlignment = .left
        label.isHidden = true
        return label
    }()
    
    init(
        title: String,
        delegate: EnterNameDelegate
    ) {
        self.delegate = delegate
        super.init(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupNextButton()
        nameTextField.becomeFirstResponder()
    }
    
    private func setupNextButton() {
        nextButtonAction = { [weak self] in
            self?.startLoading()
            self?.delegate.upload(name: self?.nameTextField.text) { [weak self] error in
                if let error = error {
                    self?.errorHandler(error: error)
                } else {
                    self?.errorLabel.isHidden = true
                }
                self?.stopLoading()
            }
        }
    }
    
    private func setupLayout() {
        [nameTextField, errorLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 32),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            errorLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            errorLabel.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor)
        ])
    }
    
    private func errorHandler(error: EnterNameDelegate.Errors) {
        switch error {
        case .emptyName, .onlyCharacters:
            errorLabel.text = error.description
            errorLabel.isHidden = false
        case .some:
            break
        }
    }
}

extension EnterNameViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nextButtonAction?()
        return true
    }
}

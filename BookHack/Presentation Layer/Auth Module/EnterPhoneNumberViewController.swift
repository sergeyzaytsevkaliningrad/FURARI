//
//  EnterPhoneNumberViewController.swift
//  Pokushats
//
//
//  Created by Сергей Зайцев on 21.03.2021.
//

import UIKit
import PhoneNumberKit
import Firebase

final class EnterPhoneNumberViewController: BaseEnterViewController {
    
    private let delegate: EnterPhoneNumberDelegate
    
    private lazy var phoneNumberTextField: EnterPhoneNumberViewController.PhoneTextField = {
        let textField = EnterPhoneNumberViewController.PhoneTextField()
        textField.placeholder = AppTexts.AuthFlow.EnterPhoneNumber.phonePlaceholder
        textField.returnKeyType = .done
        textField.keyboardType = .numberPad
        textField.backgroundColor = .clear
        textField.withPrefix = true
        textField.withFlag = true
        textField.withDefaultPickerUI = false
        textField.font = AppFonts.phoneNumber
        textField.textColor = AppColors.white
        textField.withExamplePlaceholder = true
        textField.borderStyle = .none
        return textField
    }()
    
    init(title: String, delegate: EnterPhoneNumberDelegate) {
        self.delegate = delegate
        super.init(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotifications()
        setupLayout()
        setupNextAction()
        phoneNumberTextField.becomeFirstResponder()
    }
    
    private func setupNextAction() {
        nextButtonAction = { [weak self] in
            guard let self = self else { return }
            self.startLoading()
            self.delegate.performSignIn(phoneNumber: self.phoneNumberTextField.phoneNumber?.numberString)
        }
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChangeNotifications), name: UITextField.textDidChangeNotification, object: nil)
    }
    
    private func setupLayout() {
        [phoneNumberTextField].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            phoneNumberTextField.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 32),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc private func textDidChangeNotifications() {
        if phoneNumberTextField.isValidNumber {
            enableNextButton()
        } else {
            disableNextButton()
        }
    }
}

extension EnterPhoneNumberViewController {
    class PhoneTextField: PhoneNumberTextField {
        override var defaultRegion: String {
            get {
                return Locale.current.regionCode ?? "US"
            }
            set {} // exists for backward compatibility
        }
        

        override func updatePlaceholder() {
            guard self.withExamplePlaceholder else { return }
            if isEditing, !(self.text ?? "").isEmpty { return } // No need to update a placeholder while the placeholder isn't showing

            let format = self.withPrefix ? PhoneNumberFormat.international : .national
            let example = self.phoneNumberKit.getFormattedExampleNumber(forCountry: self.currentRegion, withFormat: format, withPrefix: self.withPrefix) ?? "12345678"
            let font = self.font ?? UIFont.preferredFont(forTextStyle: .body)
            let ph = NSMutableAttributedString(string: example, attributes: [.font: font])

            #if compiler(>=5.1)
            if #available(iOS 13.0, *), self.withPrefix {
                // because the textfield will automatically handle insert & removal of the international prefix we make the
                // prefix darker to indicate non default behaviour to users, this behaviour currently only happens on iOS 13
                // and above just because that is where we have access to label colors
                let firstSpaceIndex = example.firstIndex(where: { $0 == " " }) ?? example.startIndex

                ph.addAttribute(.foregroundColor, value: AppColors.white.withAlphaComponent(0.5), range: NSRange(..<firstSpaceIndex, in: example))
                ph.addAttribute(.foregroundColor, value: AppColors.white.withAlphaComponent(0.2), range: NSRange(firstSpaceIndex..., in: example))
            }
            #endif

            self.attributedPlaceholder = ph
        }
    }
}

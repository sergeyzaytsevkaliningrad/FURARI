//
//  NumberVerificationViewController.swift
//  Pokushats
//
//  Created by Yoav Nemirovsky on 05.03.2021.
//  Copyright © 2021 Yoav. All rights reserved.
//

import UIKit

final class NumberVerificationViewController: BaseEnterViewController {
    
    private let delegate: NumberVerificationDelegate
    
    private lazy var smsCodeTextField = SmsCodeTextField()
    
    init(title: String, delegate: NumberVerificationDelegate) {
        self.delegate = delegate
        super.init(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupSmsCodeTextField()
        setupNextButtonAction()
    }
    
    private func setupSmsCodeTextField() {
        smsCodeTextField.configure()
        smsCodeTextField.didEnterLastDigit = { [weak self] smsCode in
            self?.nextButtonTapped(smsCode: smsCode)
            print(smsCode)
        }
        smsCodeTextField.becomeFirstResponder()
    }
    
    private func setupNextButtonAction() {
        nextButtonAction = { [weak self] in
            self?.nextButtonTapped(smsCode: self?.smsCodeTextField.text ?? "")
        }
    }
    
    private func setupLayout() {
        
        [smsCodeTextField].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            smsCodeTextField.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 32),
            smsCodeTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            smsCodeTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            smsCodeTextField.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func nextButtonTapped(smsCode: String) {
        self.startLoading()
        delegate.verifySmsCode(smsCode: smsCode) { [weak self] error in
            self?.stopLoading()
            self?.showAlert(error: error)
        }
    }
    
    private func showAlert(error: NumberVerificationDelegate.Errors?) {
        guard let error = error else { return }
        let controller = UIAlertController(title: error.description, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) { _ in }
        controller.addAction(action)
        self.present(controller, animated: true, completion: nil)
    }
}

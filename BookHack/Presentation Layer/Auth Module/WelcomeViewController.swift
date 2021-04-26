//
//  WelcomeViewController.swift
//  Pokushats
//
//
//  Created by Сергей Зайцев on 21.03.2021.
//

import UIKit

final class WelcomeViewController: UIViewController {
    
    enum Constants {
        static let buttonHeight: CGFloat = 45
    }
    
    private let delegate: WelcomeControllerDelegateProtocol

    private let backgroundImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "backgroundImage"))
        return imageView
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = AppTexts.AuthFlow.Welcome.headerLabel
        label.font = AppFonts.welcomeHeader
        label.textColor = AppColors.white
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let nextButton: BorderButton = {
        let button = BorderButton(type: .system)
        button.titleLabel?.font = AppFonts.buttonRegular
        button.setTitle(AppTexts.AuthFlow.Welcome.firstButtonTitle, for: .normal)
        return button
    }()
    
    init(delegate: WelcomeControllerDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupUI() {
        navigationController?.navigationBar.barStyle = .black
        let backBarButtton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtton
        
        nextButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
    }
    
    private func setupLayout() {
        [backgroundImage, nextButton, headerLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false; view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 55),
            headerLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            
            nextButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            nextButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            nextButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
        ])
    }
    
    @objc private func signInTapped() {
        delegate.signIn()
    }
    
    @objc private func signUpTapped() {
        delegate.signUp()
    }
}

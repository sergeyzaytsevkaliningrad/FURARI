//
//  BaseEnterViewController.swift
//  Pokushats
//
//
//  Created by Сергей Зайцев on 21.03.2021.
//

import UIKit

class BaseEnterViewController: LoadingIndicatorController {
    
    enum Layout {
        static let nextButtonWidth: CGFloat = 0.9
        static let buttonHeight: CGFloat = 45
        static let bottomOffset: CGFloat = 32
    }
    
    private let headerTitle: String
    
    func disableNextButton() {
        nextButton.isEnabled = false
    }
    
    func enableNextButton() {
        nextButton.isEnabled = true
    }
    
    lazy var headerLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = headerTitle
        label.font = AppFonts.welcomeHeader
        label.textColor = AppColors.white
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "backgroundImage"))
        return imageView
    }()
    
    private let nextButton: FillButton = {
        let button = FillButton(type: .system)
        button.titleLabel?.font = AppFonts.buttonRegular
        button.setTitle(AppTexts.AuthFlow.nextButton, for: .normal)
        return button
    }()
    
    var nextButtonAction: (() -> Void)?
    
    init(title: String) {
        self.headerTitle = title
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupUI() {
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = AppColors.white
        let backBarButtton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtton
    }
    
    private func setupLayout() {
        [backgroundImage, headerLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        let topOffset: CGFloat = navigationController?.navigationBar.frame.maxY ?? 0.0
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: topOffset),
            headerLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
        ])
        
        setupNextButtonLayout()
        view.addSubview(nextButton)
    }
    
    private func setupNextButtonLayout(yOffset: CGFloat = 0) {
        let nextButtonX = (view.bounds.width - view.bounds.width * Layout.nextButtonWidth) / 2
        let nextButtonY = view.bounds.maxY - Layout.buttonHeight - Layout.bottomOffset
        nextButton.frame = CGRect(
            x: nextButtonX,
            y: nextButtonY - yOffset,
            width: view.bounds.width * Layout.nextButtonWidth,
            height: Layout.buttonHeight
        )
    }
    
    @objc private func nextButtonTapped() {
        nextButtonAction?()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        setupNextButtonLayout(yOffset: keyboardSize.height)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        setupNextButtonLayout()
    }
}

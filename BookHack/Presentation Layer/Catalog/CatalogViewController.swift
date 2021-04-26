//
//  CatalogViewController.swift
//  BookHack
//
//  Created by Yoav Nemirovsky on 20.03.2021.
//

import UIKit

class CatalogViewController: UIViewController {
    
    private let viewModel: CatalogViewModel
    
    init(viewModel: CatalogViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let giveTakeButton: GiveTakeButton = {
        let giveTakeButton = GiveTakeButton(type: .system)
        giveTakeButton.setTitle("Взять книжку", for: .normal)
        return giveTakeButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.systemBackground
        title = "Каталог"
        giveTakeButton.addTarget(self, action: #selector(giveTakeButtonTapped), for: .touchUpInside)
        setupLayout()
    }
    
    private func setupLayout() {
        [giveTakeButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            giveTakeButton.heightAnchor.constraint(equalToConstant: 35),
            giveTakeButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.35),
            giveTakeButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            giveTakeButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
        ])
    }
    
    @objc private func giveTakeButtonTapped() {
        viewModel.giveTakeButtonHandler()
    }
}

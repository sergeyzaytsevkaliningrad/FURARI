//
//  UIViewController+LoadingIndicator.swift
//  Pokushats
//
//  Created by Yoav Nemirovsky on 13.12.2020.
//  Copyright © 2020 Yoav. All rights reserved.
//

import UIKit

class LoadingIndicatorController: UIViewController {
    
    private lazy var overlayView: UIView = {
        let overlayView = UIView(frame: view.frame)
        overlayView.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        return overlayView
    }()
    
    private lazy var loadingIndicator: LoadingIndicator = {
        let loader = LoadingIndicator()
        loader.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(overlayView)
        overlayView.addSubview(loader)
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor),
            loader.heightAnchor.constraint(equalToConstant: 100),
            loader.widthAnchor.constraint(equalToConstant: 100)
        ])
        return loader
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.systemBackground
    }
    
    func stopLoading() {
        loadingIndicator.stopLoading()
        overlayView.isHidden = true
    }
    
    func startLoading() {
        overlayView.isHidden = false
        loadingIndicator.startLoading()
    }
}

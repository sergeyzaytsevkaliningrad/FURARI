//
//  ViewBuilders.swift
//  BookHack
//
//  Created by Сергей Зайцев on 21.03.2021.
//

import UIKit

protocol ViewBuilderProtocol  {
    func makeAuthViewController(coordinator: MainCoordinator) -> UIViewController
}

final class ViewBuilder: ViewBuilderProtocol {
    
    func makeAuthViewController(coordinator: MainCoordinator) -> UIViewController {
        let controller = LoadingIndicatorController()
        return controller
    }
}

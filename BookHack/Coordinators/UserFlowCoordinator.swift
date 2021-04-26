//
//  UserFlowCoordinator.swift
//  BookHack
///
//  Created by Сергей Зайцев on 21.03.2021.
//

import UIKit

final class UserFlowCoordinator: UserFlowCoordinatorProtocol {
    
    var childCoordinators: [Coordinator] = []
    
    var container: [UIViewController] = []
    
    var navigationController: UINavigationController
    
    weak var parent: MainCoordinator?
    
    private let builder: UserViewBuilderProtocol
    
    
    init(navigationController: UINavigationController,
         builder: UserViewBuilderProtocol) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    func start() {
        let controller = builder.makeBookCatalogController(coordinator: self)
        controller.tabBarItem = UITabBarItem(
            title: "Каталог",
            image: UIImage(systemName: "books.vertical.fill",
                           withConfiguration: UIImage.SymbolConfiguration(weight: .semibold)), tag: 0)
        controller.title = "Каталог"
        navigationController.pushViewController(controller, animated: true)
    }
    
    func showCodeScanner() {
        let controller = builder.makeScannerCodeController(coordinator: self)
        presentController(controller: controller, animated: true, style: .fullScreen)
    }
    
    func showBook(model: BookResponseModel) {
        let controller = builder.makeBookController(model: model, coordinator: self)
        dismissPresentedController()
        navigationController.pushViewController(controller, animated: true)
    }
    
    func showProfile() {
        navigationController.popViewController(animated: false)
    }
    
    func showAr() {
        let controller = builder.makeBookCatalogController(coordinator: self)
        navigationController.pushViewController(controller, animated: false)
        //let controller = ARRealityKit.init(nibName: "ARScreen", bundle: nil)
        //presentController(controller: controller, animated: true, style: .popover)
    }
}

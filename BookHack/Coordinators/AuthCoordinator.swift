//
//  AuthCoordinator.swift
//  Pokushats
//
//
//  Created by Сергей Зайцев on 21.03.2021.
//

import UIKit

final class AuthCoordinator: AuthCoordinatorProtocol {

    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    var container: [UIViewController] = []
    
    private let builder: AuthViewBuilderProtocol
    
    private let window: UIWindow
    
    weak var parentCoordinator: MainCoordinator?
    
    init(
        navigationController: UINavigationController,
        builder: AuthViewBuilderProtocol,
        window: UIWindow
    ) {
        self.navigationController = navigationController
        self.builder = builder
        self.window = window
    }
    
    func start() {
        let controller = builder.createWelcomeController(coordinator: self)
        navigationController.viewControllers = [controller]
        container.append(controller)
        window.rootViewController = navigationController
        UIView.transition(with: self.window,
                          duration: 0.6,
                          options: [.transitionFlipFromLeft],
                          animations: nil, completion: nil)
    }
    
    func showSignUp() {
        let controller = builder.createAuthWithNumberController(coordinator: self)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func showSignIn() {
        let controller = builder.createAuthWithNumberController(coordinator: self)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func showVerifyPhoneNumber(title: String) {
        let controller = builder.createNumberVerificationController(coordinator: self, title: title)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func authWithPhoneSuccesfully() {
        let controller = builder.createEnterNameController(coordinator: self)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func authCompleted() {
        parentCoordinator!.userAuthDidFinish(self)
    }
}

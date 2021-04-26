//
//  CoordinatorProtocol.swift
//  BookHack
//
//  Created by Сергей Зайцев on 21.03.2021.
//

import UIKit

protocol Coordinator: AnyObject {

    var childCoordinators: [Coordinator] { get set }
    var container: [UIViewController] { get set }
    var navigationController: UINavigationController { get set }

    func start()
    func presentController(controller: UIViewController, animated: Bool, style: UIModalPresentationStyle)
    func dismissPresentedController()
}

extension Coordinator {
    func presentController(controller: UIViewController,
                           animated: Bool,
                           style: UIModalPresentationStyle) {
        controller.modalPresentationStyle = style
        if container.last != nil {
            container.last?.present(controller, animated: animated, completion: nil)
        }
        navigationController.topViewController?.present(controller, animated: true, completion: nil)
        container.append(controller)
    }

    func dismissPresentedController() {
        container.last?.dismiss(animated: true, completion: nil)
        container.removeLast()
    }
    
    func popLast() {
        navigationController.popViewController(animated: true)
        container.removeLast()
    }
}


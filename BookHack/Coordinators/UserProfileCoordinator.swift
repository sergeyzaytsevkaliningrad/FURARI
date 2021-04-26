//
//  UsersRaiting.swift
//  BookHack
//
//  Created by Сергей Зайцев on 21.03.2021.
//
import UIKit
import SwiftUI

class UserProfileCoordinator: UserProfileCoordinatorProtocol {
    
    var childCoordinators: [Coordinator] = []
    
    var container: [UIViewController] = []
    
    var navigationController: UINavigationController
    
    weak var parentCoordinator: MainCoordinator?
    
    private let networkService: InnerNetworkServiceProtocol
    
    init(navigationController: UINavigationController,
         networkService: InnerNetworkServiceProtocol) {
        self.navigationController = navigationController
        self.networkService = networkService
    }
    
    func start() {
        let viewModel = UserProfileViewModel(coordinator: self, networkService: networkService)
        let view = UserProfileView(viewModel: viewModel)
        let controller = UIHostingController(rootView: view)
        controller.title = "Профиль"
        controller.tabBarItem = UITabBarItem(
            title: "Профиль",
            image: UIImage(systemName: "person.crop.circle.fill",
                           withConfiguration: UIImage.SymbolConfiguration(weight: .semibold)), tag: 1)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func userSignOut() {
        parentCoordinator?.userSignOut(self)
    }
    
    func userReturnBook() {
        navigationController.popViewController(animated: true)
    }
}

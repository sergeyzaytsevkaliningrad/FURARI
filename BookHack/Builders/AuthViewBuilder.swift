//
//  AuthViewBuilder.swift
//  Pokushats
//
//
//  Created by Сергей Зайцев on 21.03.2021.
//

import Foundation
import UIKit

protocol AuthViewBuilderProtocol {
    func createWelcomeController(coordinator: AuthCoordinatorProtocol) -> UIViewController
    func createAuthWithNumberController(coordinator: AuthCoordinatorProtocol) -> UIViewController
    func createNumberVerificationController(coordinator: AuthCoordinatorProtocol, title: String) -> UIViewController
    func createEnterNameController(coordinator: AuthCoordinatorProtocol) -> UIViewController
}

final class AuthViewBuilder: AuthViewBuilderProtocol {
    
    private let authService: FirebaseAuthServiceProtocol
    private let networkService: InnerNetworkServiceProtocol
    
    init(
        authService: FirebaseAuthServiceProtocol,
        networkService: InnerNetworkServiceProtocol
    ) {
        self.authService = authService
        self.networkService = networkService
    }
    
    func createWelcomeController(coordinator: AuthCoordinatorProtocol) -> UIViewController {
        let delegate = WelcomeControllerDelegate(coordinator: coordinator)
        let controller = WelcomeViewController(delegate: delegate)
        return controller
    }
    
    func createAuthWithNumberController(coordinator: AuthCoordinatorProtocol) -> UIViewController {
        let delegate = EnterPhoneNumberDelegate(authService: authService, coordinator: coordinator)
        let controller = EnterPhoneNumberViewController(
            title: AppTexts.AuthFlow.EnterPhoneNumber.title,
            delegate: delegate
        )
        return controller
    }
    
    func createNumberVerificationController(coordinator: AuthCoordinatorProtocol, title: String) -> UIViewController {
        let delegate = NumberVerificationDelegate(authService: authService, coordinator: coordinator)
        let controller = NumberVerificationViewController(
            title: title,
            delegate: delegate
        )
        return controller
    }
    
    func createEnterNameController(coordinator: AuthCoordinatorProtocol) -> UIViewController {
        let delegate = EnterNameDelegate(coordinator: coordinator, networkService: networkService)
        let controller = EnterNameViewController(title: AppTexts.AuthFlow.EnterName.title, delegate: delegate)
        return controller
    }
}

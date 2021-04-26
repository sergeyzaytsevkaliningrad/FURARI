//
//  WelcomeControllerDelegate.swift
//  Pokushats
//
//
//  Created by Сергей Зайцев on 21.03.2021.
//

import Foundation

protocol WelcomeControllerDelegateProtocol {
    func signIn()
    func signUp()
}

final class WelcomeControllerDelegate: WelcomeControllerDelegateProtocol {
    private let coordinator: AuthCoordinatorProtocol
    
    init(coordinator: AuthCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func signIn() {
        coordinator.showSignIn()
    }
    
    func signUp() {
        coordinator.showSignUp()
    }
}

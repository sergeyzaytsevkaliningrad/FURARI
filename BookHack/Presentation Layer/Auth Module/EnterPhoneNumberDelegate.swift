//
//  EnterPhoneNumberDelegate.swift
//  Pokushats
//
//
//  Created by Сергей Зайцев on 21.03.2021.
//
import Foundation

final class EnterPhoneNumberDelegate {
    
    private let authService: FirebaseAuthServiceProtocol
    private let coordinator: AuthCoordinatorProtocol
    
    init(authService: FirebaseAuthServiceProtocol, coordinator: AuthCoordinatorProtocol) {
        self.authService = authService
        self.coordinator = coordinator
    }
    
    func performSignIn(phoneNumber: String?) {
        authService.performSignIn(phoneNumber: phoneNumber) { [weak self] result in
            switch result {
            case .success:
                print("Успешно получили смс")
                //-----------SAME
              //  self?.coordinator.showVerifyPhoneNumber(title: AppTexts.AuthFlow.PhoneVerification.title + (phoneNumber ?? ""))
            case .failure(let error):
                print(error.description)
            }
        }
    }
}

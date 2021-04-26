//
//  NumberVerificationDelegate.swift
//  Pokushats
//
//
//  Created by Сергей Зайцев on 21.03.2021.
//
import Foundation

final class NumberVerificationDelegate {
    
    private let authService: FirebaseAuthServiceProtocol
    private let coordinator: AuthCoordinatorProtocol
    
    init(authService: FirebaseAuthServiceProtocol, coordinator: AuthCoordinatorProtocol) {
        self.authService = authService
        self.coordinator = coordinator
    }
    
    func verifySmsCode(smsCode: String?, completion: @escaping (Errors?) -> Void) {
        authService.verifySmsCode(verificationCode: smsCode) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    completion(nil)
                    self?.authService.isUsernameExist { [weak self] isExist in
                        if isExist {
                            self?.coordinator.authCompleted()
                        } else {
                           
                            //-------------------------SAME
                            self?.coordinator.authWithPhoneSuccesfully()
                        }
                    }
                }
            case .failure(let error):
                switch error {
                case .authWithPhoneNumberFailed:
                    DispatchQueue.main.async {
                        completion(.wrongSmsCode)
                    }
                default:
                    print(error.description)
                }
            }
        }
    }
    
    enum Errors: Error {
        case wrongSmsCode
        
        var description: String {
            switch self {
            case .wrongSmsCode:
                return AppTexts.AuthFlow.PhoneVerification.wrongCodeError
            }
        }
    }
}

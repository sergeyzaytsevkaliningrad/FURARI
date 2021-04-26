//
//  AuthServiceProtocol.swift
//  Pokushats
//
//
//  Created by Сергей Зайцев on 21.03.2021.
//

import Foundation

protocol FirebaseAuthServiceProtocol {
    func performSignIn(phoneNumber: String?, completion: @escaping (Result<Void, AuthService.Errors>) -> Void)
    func verifySmsCode(verificationCode: String?, completion: @escaping (Result<Void, AuthService.Errors>) -> Void)
    func isUserExist() -> Bool
    func isUsernameExist(completion: @escaping (Bool) -> Void)
    func signOutUser() throws
}

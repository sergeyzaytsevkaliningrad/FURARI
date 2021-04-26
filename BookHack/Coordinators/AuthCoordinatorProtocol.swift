//
//  AuthCoordinatorProtocol.swift
//  Pokushats
//
//
//  Created by Сергей Зайцев on 21.03.2021.
//

import Foundation

protocol AuthCoordinatorProtocol: Coordinator {
    func showSignUp()
    func showSignIn()
    func showVerifyPhoneNumber(title: String)
    func authWithPhoneSuccesfully()
    func authCompleted()
}

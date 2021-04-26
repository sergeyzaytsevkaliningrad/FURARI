//
//  UserFlowCoordinatorProtocol.swift
//  BookHack
//
//  Created by Сергей Зайцев on 21.03.2021.
//

import Foundation

protocol UserFlowCoordinatorProtocol: Coordinator {
    func showCodeScanner()
    func showBook(model: BookResponseModel)
    func showProfile()
    func showAr()
}

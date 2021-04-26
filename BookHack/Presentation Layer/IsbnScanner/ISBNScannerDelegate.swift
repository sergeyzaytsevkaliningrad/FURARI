//
//  ISBNScannerDelegate.swift
//  BookHack
//
//  Created by Yoav Nemirovsky on 20.03.2021.
//

import Foundation

final class ISBNScannerDelegate {
    private let ISBNService: IsbnNetworkServiceProtocol
    private let firebaseService: InnerNetworkServiceProtocol
    private let coordinator: UserFlowCoordinatorProtocol
    
    init(
        ISBNService: IsbnNetworkServiceProtocol,
        firebaseService: InnerNetworkServiceProtocol,
        coordinator: UserFlowCoordinatorProtocol
    ) {
        self.ISBNService = ISBNService
        self.firebaseService = firebaseService
        self.coordinator = coordinator
    }
    
    func ISBNCodeHandler(code: String) {
        print(code)
        ISBNService.getBookInfo(by: code) { result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self.coordinator.showBook(model: model)
                    print(model)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

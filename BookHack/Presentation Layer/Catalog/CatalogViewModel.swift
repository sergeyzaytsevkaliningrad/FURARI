//
//  CatalogViewModel.swift
//  BookHack
//
//  Created by Yoav Nemirovsky on 20.03.2021.
//

import Foundation

final class CatalogViewModel: ObservableObject {
    private let networkService: InnerNetworkServiceProtocol
    private let coordinator: UserFlowCoordinatorProtocol
    
    @Published var books: [BookResponseModel] = []
    
    init(networkService: InnerNetworkServiceProtocol,
         coordinator: UserFlowCoordinatorProtocol) {
        self.networkService = networkService
        self.coordinator = coordinator
    }
    
    func giveTakeButtonHandler() {
        coordinator.showCodeScanner()
    }
    
    func ARHandler() {
        coordinator.showAr()
    }
    
    func loadBooks() {
        networkService.loadBooks(amount: 10) { [weak self] books in
            DispatchQueue.main.async {
                self?.books = books
            }
        }
    }
}

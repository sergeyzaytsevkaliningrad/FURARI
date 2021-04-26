//
//  UserProfileViewModel.swift
//  BookHack
//
//  Created by Yoav Nemirovsky on 21.03.2021.
//

import Foundation

class UserProfileViewModel: ObservableObject {
    
    private let coordinator: UserProfileCoordinatorProtocol
    private let networkService: InnerNetworkServiceProtocol
    
    init(coordinator: UserProfileCoordinatorProtocol,
         networkService: InnerNetworkServiceProtocol) {
        self.coordinator = coordinator
        self.networkService = networkService
    }
    
    @Published var name = ""
    @Published var phoneNumber = ""
    @Published var reservedBooks: [BookResponseModel] = []
    
    func loadUserInfo() {
        networkService.loadUserInfo { result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self.name = model.username ?? "empty"
                    self.phoneNumber = model.phoneNumber ?? "empty"
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadReservedBooks() {
        networkService.loadReservedBooks { [weak self] books in
            DispatchQueue.main.async {
                self?.reservedBooks = books
            }
        }
    }
    
    func returnBook(book: BookResponseModel) {
        networkService.deleteBook(isbn: book.isbn) { [weak self] error in
            DispatchQueue.main.async {
                self?.coordinator.userReturnBook()
            }
        }
    }
    
    func userSignOut() {
        coordinator.userSignOut()
    }
}

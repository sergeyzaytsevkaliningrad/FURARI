//
//  EnterNameDeleagte.swift
//  Pokushats
//
//
//  Created by Сергей Зайцев on 21.03.2021.
//

import Foundation

final class EnterNameDelegate {
    private let coordinator: AuthCoordinatorProtocol
    private let networkService: InnerNetworkServiceProtocol
    
    init(coordinator: AuthCoordinatorProtocol,
         networkService: InnerNetworkServiceProtocol) {
        self.coordinator = coordinator
        self.networkService = networkService
    }
    
    func upload(name: String?, completion: @escaping (Errors?) -> Void) {
        guard let name = name, !name.isEmpty else {
            completion(.emptyName)
            return
        }
        
        guard name.trimmingCharacters(in: .whitespacesAndNewlines) != "" else {
            completion(.onlyCharacters)
            return
        }
        
        for unicodeElem in name.unicodeScalars {
            guard CharacterSet.letters.contains(unicodeElem) else {
                completion(.onlyCharacters)
                return
            }
        }
        
        networkService.upload(username: name) { [weak self] result in
            switch result {
            case .success:
                self?.coordinator.authCompleted()
                completion(nil)
                return
            case .failure(let error):
                print(error.localizedDescription)
                completion(.some)
                
            }
        }
    }
    
    enum Errors: Error {
        case emptyName
        case onlyCharacters
        case some
        
        var description: String {
            switch self {
            case .emptyName:
                return "Имя не может быть пустым"
            case .onlyCharacters:
                return "Используйте только буквы"
            default:
                return "Произошла неизвестная ошибка"
            }
        }
    }
}

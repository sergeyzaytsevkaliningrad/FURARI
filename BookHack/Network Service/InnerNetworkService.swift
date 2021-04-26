//
//  InnerNetworkService.swift
//  Pokushats
//
//
//  Created by Сергей Зайцев on 21.03.2021.
//

import Firebase
import Foundation
import FirebaseFirestoreSwift

final class InnerNetworkService: InnerNetworkServiceProtocol {
    
    enum FirebaseCollection {
        static let users = "Users"
        static let Orders = "Orders"
    }
    
    private let db = Firestore.firestore()
    
    
    func loadBooks(amount: Int, completion: @escaping ([BookResponseModel]) -> Void) {
        db.collection("library").getDocuments { (querySnapshot, error) in
            if let error = error {
                print(error.localizedDescription)
                completion([])
            } else if let documents = querySnapshot?.documents {
                let books = documents.compactMap { try? $0.data(as: BookResponseModel.self) }
                completion(books)
            }
        }
    }
    
    func loadReservedBooks(completion: @escaping ([BookResponseModel]) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        db.collection(FirebaseCollection.users).document(userId).collection("Reserved").getDocuments { (querySnapshot, error) in
            if let error = error {
                print(error.localizedDescription)
                completion([])
            } else if let documents = querySnapshot?.documents {
                let books = documents.compactMap { try? $0.data(as: BookResponseModel.self) }
                completion(books)
            }
        }
    }
    
    
    func reserveBook(book: BookResponseModel, completion: @escaping (Error?) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        _ = try? db.collection(FirebaseCollection.users).document(userId).collection("Reserved").document(book.isbn).setData(from: book)
        completion(nil)
    }
    
    func deleteBook(isbn: String, completion: @escaping (Error?) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        db.collection(FirebaseCollection.users).document(userId).collection("Reserved").document(isbn).delete(completion: completion)
    }
    
    func upload(username: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            completion(.failure(Errors.userIdNotFound))
            return
        }
        db.collection(FirebaseCollection.users).document(userId).updateData(["username": username]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func getUsername(completion: @escaping (Result<String, Error>) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            completion(.failure(Errors.userIdNotFound))
            return
        }
        db.collection(FirebaseCollection.users).document(userId).getDocument { document, error in
            if let error = error {
                completion(.failure(error))
            } else {
                guard let username = document?.data()?["username"] as? String else {
                    completion(.failure(Errors.userNameNotFound))
                    return
                }
                completion(.success(username))
            }
        }
    }
    
    func loadUserInfo(completion: @escaping (Result<UserInfoModel, Error>) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            completion(.failure(Errors.userIdNotFound))
            return
        }
        db.collection(FirebaseCollection.users).document(userId).getDocument { document, error in
            if let error = error {
                completion(.failure(error))
            } else {
                guard let userData = try? document?.data(as: UserInfoModel.self) else {
                    completion(.failure(Errors.userNameNotFound))
                    return
                }
                completion(.success(userData))
            }
        }

    }
    
    enum Errors: Error {
        case userNameNotFound
        case userIdNotFound
        case queryDocumentsNotFound
        case unknown(Error)
    }
}

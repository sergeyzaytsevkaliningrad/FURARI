//
//  InnerNetworkServiceProtocol.swift
//  Pokushats
//
//
//  Created by Сергей Зайцев on 21.03.2021.
//

import Foundation

protocol InnerNetworkServiceProtocol {
    func upload(username: String, completion: @escaping (Result<Void, Error>) -> Void)
    func getUsername(completion: @escaping (Result<String, Error>) -> Void)
    func loadUserInfo(completion: @escaping (Result<UserInfoModel, Error>) -> Void)
    func reserveBook(book: BookResponseModel, completion: @escaping (Error?) -> Void)
    func deleteBook(isbn: String, completion: @escaping (Error?) -> Void)
    func loadReservedBooks(completion: @escaping ([BookResponseModel]) -> Void)
    func loadBooks(amount: Int, completion: @escaping ([BookResponseModel]) -> Void)
}

struct UserInfoModel: Codable {
    let username: String?
    let phoneNumber: String?
}

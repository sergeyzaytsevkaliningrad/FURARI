//
//  IsbnNetworkServiceProtocol.swift
//  BookHack
//
//  Created by Сергей Зайцев on 21.03.2021.
//

import Foundation

protocol IsbnNetworkServiceProtocol {
    func getBookInfo(by isbn: String, completion: @escaping (Result<BookResponseModel, Error>) -> Void)
}

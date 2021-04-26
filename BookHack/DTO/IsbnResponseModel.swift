//
//  IsbnResponseModel.swift
//  BookHack
//
//  Created by Сергей Зайцев on 21.03.2021.
//

import Foundation

struct BookResponseModel: Codable, Hashable {
    var title: String
    var author: String
    var isbn: String
    var imageUrl: String?
    var publisher: String?
    var owner: String?
}

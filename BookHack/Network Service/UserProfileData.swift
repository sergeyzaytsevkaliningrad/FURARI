//
//  UserProfileData.swift
//  Pokushats
//
//
//  Created by Сергей Зайцев on 21.03.2021.
//

import Foundation

struct UserProfileData: Codable {
    var name: String?
    let phoneNumber: String?
    var email: String?
    var birthday: String?
    var sex: String?
    
    enum CodingKeys: String, CodingKey {
        case phoneNumber, email, birthday, sex
        case name = "username"
    }
}

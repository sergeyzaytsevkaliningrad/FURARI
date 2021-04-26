//
//  AuthServiceErrors.swift
//  Pokushats
//
//
//  Created by Сергей Зайцев on 21.03.2021.
//
extension AuthService {
    enum Errors: Error {
        case userNotFound
        case none(error: Error)
        case unknownAccount(message: String)
        case authWithPhoneNumberFailed(error: Error?)
        case numberIsNotExist
        case verificationCodeNotExist
        case verificationIdNotFound
        
        var description: String {
            switch self {
            case .userNotFound:
                return "UID Юзера не найден"
            case .none(let error):
                return error.localizedDescription
            case .unknownAccount(let message):
                return message
            case .authWithPhoneNumberFailed(let error):
                return "Не удалось пройти аутентификацию \(error?.localizedDescription ?? "")"
            case .numberIsNotExist:
                return "Номер телефона не существует"
            case .verificationCodeNotExist:
                return "Не найден проверочный смс код"
            case .verificationIdNotFound:
                return "Не найден id верификации"
            }
        }
    }
}

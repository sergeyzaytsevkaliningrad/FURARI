//
//  AppTexts.swift
//  Pokushats
//
//  Created by Yoav Nemirovsky on 04.09.2020.
//  Copyright © 2020 Yoav. All rights reserved.
//

import Foundation

enum AppTexts {
    
    enum AuthFlow {
        
        enum EnterPhoneNumber {
            static let phonePlaceholder = "Введите номер телефона"
            static let title = "Введите ваш номер телефона"
        }
        
        enum PhoneVerification {
            static let title = "Введите 6-значный код, отправленный на "
            static let wrongCodeError = "Вы ввели неверный код. Пожалуйста, попробуйте еще раз."
        }
        
        enum EnterName {
            static let title = "Ваше имя:"
            static let namePlaceHolder = ". . ."
        }
        
        static let nextButton = "Продолжить"
        
        enum Welcome {
            static let headerLabel = "Чтобы забрать книжку, нужно зарегистрироваться :)"
            static let firstButtonTitle = "Далее"
        }
        
    }
}

//
//  Tutor.swift
//
//  InstructionData.swift
//  BookHack
//
//  Created by Сергей Зайцев on 21.03.2021.
//


import SwiftUI

struct InstructionData: Identifiable {
    var id = UUID()
    var name: String
    var headline: String
    var bio: String
    //var points: String
    
    var imageName: String { return name }
}

let instructionTestData = [
    InstructionData(name: "Обнаружено падение напряжения в шине питания",
          headline: "C48",
          bio: "Проблема, связанная с ошибкой: Ошибка на шине питания 48 В"
         ),
    InstructionData(name: "Аварийный отказ реле",
          headline: "C51",
          bio: "Проблема, связанная с ошибкой: Ошибка главной платы"
          ),
    InstructionData(name: "Ошибка связи с ПК",
          headline: "C10",
          bio: ""
          ),
]

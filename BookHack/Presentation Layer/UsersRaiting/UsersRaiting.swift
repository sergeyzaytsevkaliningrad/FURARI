////
////  UsersRaiting.swift
////  BookHack
////
////  Created by Сергей Зайцев on 21.03.2021.
////
//
//import SwiftUI
//
//struct UsersRaiting: View {
//    var tutors: [Tutor] = testData
//    @State var showGoodRaiting: Bool = false
//    @State var isPresented: Bool = false
//
//
//    var lel: some View {
//        Image("Info")
//            .resizable()
//            .aspectRatio(contentMode: .fit)
//            .padding()
//            .background(SwiftUI.Image("Coolerbackground").edgesIgnoringSafeArea(.all))
//    }
//
//
//    var body: some View {
//
//        VStack {
//            Label("Должники", systemImage: "calendar")
//                .font(.largeTitle)
//                .accentColor(.red)
//                .colorScheme(.dark)
//            VStack(alignment: .leading) {
//                Button("Инфо") {
//                    isPresented.toggle()
//                }
//                .popover(isPresented: $isPresented) {
//                    lel
//                }
//            }
//            .padding()
//            List(tutors) { tutor in
//                Image(tutor.imageName).cornerRadius(30.0)
//                VStack(alignment: .leading) {
//                    Text(tutor.name)
//                        .font(.title3)
//                    Text(tutor.headline)
//                        .font(.subheadline)
//                        .foregroundColor(.gray)
//                    Text(tutor.points)
//                        .foregroundColor(.red)
//
//                }
//            }
//            .cornerRadius(25)
//            .padding()
//        }
//        .background(SwiftUI.Image("Coolerbackground").edgesIgnoringSafeArea(.all))//.hidden()
//
//        //Good raiting
//        //        VStack {
//        //            Label("Лучшие читатели", systemImage: "calendar")
//        //                .font(.largeTitle)
//        //                .accentColor(.red)
//        //                .colorScheme(.dark)
//        //                    VStack(alignment: .leading) {
//        //                    Toggle(isOn: $showGoodRaiting) {
//        //                        Label("Лучшие читатели", systemImage: "book")
//        //                            .colorScheme(.dark)
//        //                            .font(.title2)
//        //                     }
//        //                    }
//        //            List(tutors) { tutor in
//        //                Image(tutor.imageName).cornerRadius(30.0)
//        //                VStack(alignment: .leading) {
//        //                    Text(tutor.name)
//        //                        .font(.title3)
//        //                    Text(tutor.headline)
//        //                        .font(.subheadline)
//        //                        .foregroundColor(.gray)
//        //                    Text(tutor.points)
//        //                        .foregroundColor(.green)
//        //
//        //
//        //
//        //                }
//        //            }
//        //        }.hidden()
//    }
//}
//
//
//
//struct UsersRaiting_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            UsersRaiting(tutors: testData)
//        }
//    }
//}


//
//  ARRealityKit.swift
//  BookHack
//
//  Created by Сергей Зайцев on 25.04.2021.
//

import SwiftUI

struct ARRealityKit: View {
    var instructions: [InstructionData] = instructionTestData
    @State var showGoodRaiting: Bool = false
    @State var isPresented: Bool = false
    
    var body: some View {
        
        VStack {
            Label("Информирование", systemImage: "list")
                .font(.largeTitle)
                .accentColor(.red)
                .colorScheme(.dark)
                //            VStack(alignment: .leading) {
                //                Button("Инфо") {
                //                    isPresented.toggle()
                //                }
                //                .popover(isPresented: $isPresented) {
                //                    nil
                //                }
                //            }
                .padding()
            //            List(instructions) { tutor in
            //                //Image(tutor.imageName).cornerRadius(30.0)
            //                VStack(alignment: .leading) {
            //                    Text(tutor.name)
            //                        .font(.title3)
            //                    Text(tutor.headline)
            //                        .font(.subheadline)
            //                        .foregroundColor(.gray)
            ////                    Text(tutor.points)
            ////                        .foregroundColor(.red)
            //
            //                }
            //            }
            List(robotsList, children: \.subinfo) { row in
                Text(row.info)
                    .bold()
                    .padding()
            }
            .cornerRadius(25)
            .padding()
        }
        .background(SwiftUI.Image("Coolerbackground").edgesIgnoringSafeArea(.all))
    }
}

struct ARRealityKit_Previews: PreviewProvider {
    static var previews: some View {
        ARRealityKit()
    }
}

struct RobotsInfo: Identifiable {
    let id = UUID()
    let info: String
    var subinfo: [RobotsInfo]?
}

let robotsList = [
    RobotsInfo(info: "UR3", subinfo: [RobotsInfo(info: "The UR3e collaborative robot is a smaller collaborative table-top robot, perfect for light assembly tasks and automated workbench scenarios. The compact table-top cobot weighs only 24.3 lbs (11 kg), but has a payload of 6.6 lbs (3 kg),  ±360-degree rotation on all wrist joints, and infinite rotation on the end joint.")]),
    RobotsInfo(info: "UR5", subinfo: [RobotsInfo(info: "Built with the future in mind, the UR5e is designed to grow in capability alongside your business, a spring board to improved product quality and productivity, so you will always be able to stay ahead of competition. Equipped with intuitive programming, versatile use and an almost endless list of opportunities for add-ons, the UR5e is able to complement production regardless of your industry, company size or product nature.")]),
    RobotsInfo(info: "UR10", subinfo: [RobotsInfo(info: "The Universal Robots UR10e is an extremely versatile collaborative industrial robot arm with its high payload (10kg) and long reach capability.  Its 1300mm reach spans wide workspaces without compromising precision or payload performance.  UR10e addresses a wide range of applications in machine tending, palletizing, and packaging.")]),
    RobotsInfo(info: "UR16", subinfo: [RobotsInfo(info: "The Universal Robots UR16e delivers an impressive 16kg (35.3 lbs.) of payload within a small footprint, and is ideal for use in heavy machine tending, material handling, packaging, and screw and nut driving applications. This powerhouse robot allows for heavier end of arm tooling and multi-part handling, and is especially useful for achieving shorter cycle times.")]),
]

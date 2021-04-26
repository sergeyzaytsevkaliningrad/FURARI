////
////  ARRealityKit.swift
////  BookHack
////
////  Created by Сергей Зайцев on 25.04.2021.
////
//
//import SwiftUI
//
//struct ARRealityKit: View {
//    var instructions: [InstructionData] = instructionTestData
//    @State var showGoodRaiting: Bool = false
//    @State var isPresented: Bool = false
//    
//    var body: some View {
//        
//        VStack {
//            Label("Инструкции", systemImage: "list")
//                .font(.largeTitle)
//                .accentColor(.red)
//                .colorScheme(.dark)
////            VStack(alignment: .leading) {
////                Button("Инфо") {
////                    isPresented.toggle()
////                }
////                .popover(isPresented: $isPresented) {
////                    nil
////                }
////            }
//            .padding()
//            List(instructions) { tutor in
//                //Image(tutor.imageName).cornerRadius(30.0)
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
//        .background(SwiftUI.Image("Coolerbackground").edgesIgnoringSafeArea(.all))
//    }
//}
//
//struct ARRealityKit_Previews: PreviewProvider {
//    static var previews: some View {
//        ARRealityKit()
//    }
//}

////
////  ARRealityKit.swift
////  BookHack
////
////  Created by Сергей Зайцев on 25.04.2021.
////
//
import SwiftUI
import UIKit
import RealityKit

struct RealityView: View {
    var body: some View {
        RealityIntegratedViewController()
        .navigationBarTitle(Text(""), displayMode: .inline)
    }
}

class RealityViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Add a background color a placerholder
        view.backgroundColor = .systemBlue
        //Comment out below this when previewing!
        // Create a new ARView
        let arView = ARView(frame: UIScreen.main.bounds)
        // Add the ARView to the view
        view.addSubview(arView)
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Bolt.loadBox()
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
    }
}

struct RealityIntegratedViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<RealityIntegratedViewController>) -> RealityIntegratedViewController.UIViewControllerType {
        return RealityViewController()
    }
    func updateUIViewController(_ uiViewController: RealityViewController, context: UIViewControllerRepresentableContext<RealityIntegratedViewController>) {
    }
}
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

//
//  PDFKitView.swift
//  BookHack
//
//  Created by Rudolf Oganesyan on 26.04.2021.
//

import SwiftUI

import PDFKit
struct PDFKitView: View {
    var url: URL
    var body: some View {
        PDFKitRepresentedView(url)
            .navigationBarItems(trailing: NavigationLink(
                                    destination: RealityView(),
                                    label: {
                                        Text("Go to AR").font(.largeTitle)
                                    }))
    }
}

struct PDFKitRepresentedView: UIViewRepresentable {
    let url: URL
    init(_ url: URL) {
        self.url = url
    }
    
    func makeUIView(context: UIViewRepresentableContext<PDFKitRepresentedView>) -> PDFKitRepresentedView.UIViewType {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: self.url)
        pdfView.autoScales = true
        
        return pdfView
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PDFKitRepresentedView>) {
        // Update the view.
    }
}

//struct wre_Previews: PreviewProvider {
//    static var previews: some View {
//        PDFKitView()
//    }
//}


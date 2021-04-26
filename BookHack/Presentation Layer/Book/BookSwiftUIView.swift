//
//  BookSwiftUIView.swift
//  BookHack
//
//  Created by Yoav Nemirovsky on 21.03.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct BookSwiftUIView: View {
    
    private let viewModel: BookViewModelProtocol
    
    init(viewModel: BookViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .center) {
            WebImage(url: URL(string: viewModel.imageUrl))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 250, height: 350, alignment: .center)
                .cornerRadius(25)
                .clipped()
            Text(viewModel.title)
                .font(.title)
            Text(viewModel.author)
                .font(.title2)
            Text("ISBN: \(viewModel.isbnCode)")
                .font(.headline)
            Button("Забрать книжку") {
                takeBook()
            }
            .padding(.vertical)
            .font(.headline)
        }
        .padding()
    }
    
    private func takeBook() {
        print("Нажал на взять книжку")
        viewModel.handleTakeBook()
    }
}

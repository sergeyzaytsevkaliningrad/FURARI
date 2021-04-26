//
//  CatalogSwiftView.swift
//  BookHack
//
//  Created by Yoav Nemirovsky on 21.03.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct CatalogSwiftView: View {
    
    @ObservedObject private var viewModel: CatalogViewModel
    
    init(viewModel: CatalogViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .center) {
            List(viewModel.books, id: \.isbn) { book in
                    WebImage(url: URL(string: book.imageUrl ?? ""))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100, alignment: .center)
                    .cornerRadius(25)
                    .clipped()
                VStack(alignment: .leading) {
                    Text(book.title)
                        .font(.title3)
                    NavigationLink(destination: CatalogDetailedView(viewModel: CatalogDetailedViewModel(book: book))) {
                        Text("")
                            .font(.caption2)
                            .foregroundColor(.gray)
                    }
                    Text(book.author)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("Издательство: \(book.publisher ?? "")")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .cornerRadius(25)
            .padding()
            Spacer()
            Button {
                viewModel.giveTakeButtonHandler()
            } label: {
                Text("Забрать книжку")
                    .frame(width: 200, height: 35, alignment: .center)
                    .foregroundColor(.white)
                    .background(Color.purple)
                    .cornerRadius(25)
                    .clipped()
            }
            .padding()
        }
        .onAppear(perform: viewModel.loadBooks)
        .background(SwiftUI.Image("Coolerbackground").edgesIgnoringSafeArea(.all))
    }
}

struct CatalogDetailedView: View {
    
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
            Text("Где взять: pickpoint 1")
                .font(.headline)
        }
        .padding()
    }
    
    private func takeBook() {
        print("Нажал на взять книжку")
        viewModel.handleTakeBook()
    }
}

class CatalogDetailedViewModel: BookViewModelProtocol {
    
    let book: BookResponseModel
    
    init(book: BookResponseModel) {
        self.book = book
    }
    
    var author: String {
        return book.author
    }
    
    var title: String {
        return book.title
    }
    
    var isbnCode: String {
        return book.isbn
    }
    
    var imageUrl: String {
        return book.imageUrl ?? ""
    }
    
    func handleTakeBook() {
        
    }
    
    
}




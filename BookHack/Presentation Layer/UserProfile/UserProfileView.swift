//
//  UserProfileView.swift
//  BookHack
//
//  Created by Yoav Nemirovsky on 21.03.2021.
//

import SwiftUI
import UIKit
import SDWebImageSwiftUI

struct UserProfileView: View {
    
    @ObservedObject private var viewModel: UserProfileViewModel
    
    init(viewModel: UserProfileViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Мои данные:")
                        .foregroundColor(Color.gray)
                        .font(.title2)
                    Text("\(viewModel.name)")
                        .font(.title3)
                    Text("\(viewModel.phoneNumber)")
                        .font(.title3)
                }
                Spacer()
            }.padding(.bottom, 20)
            Text("Читаю сейчас:")
                .foregroundColor(Color.gray)
                .font(.title2)
            reservedBooks
            Button("Выйти", action: logOut)
        }
        .padding()
        .onAppear(perform: loadUserInfo)
    }
    
    var reservedBooks: some View {
        List(viewModel.reservedBooks, id: \.isbn) { book in
            VStack(alignment: .leading) {
                HStack {
                    AnimatedImage(url: URL(string: book.imageUrl ?? ""))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 80, alignment: .center)
                        .clipped()
                    VStack(alignment: .leading) {
                        Text(book.title)
                            .font(.title3)
                        Text(book.author)
                            .font(.title3)
                        Text("ISBN: \(book.isbn)")
                            .font(.caption)
                        NavigationLink(destination: BookDetailedView(book: book, viewModel: viewModel)) {
                            Text("Вернуть книжку")
                                .foregroundColor(.gray)
                        
                        }
                    }
                }
            }
        }
    }
    
    private func loadUserInfo() {
        viewModel.loadUserInfo()
        viewModel.loadReservedBooks()
    }
    
    private func logOut() {
        viewModel.userSignOut()
    }
}

struct BookDetailedView: View {
    
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    
    var body: some View {
        NavigationView {
            VStack {
                if selectedImage != nil {
                    Image(uiImage: selectedImage!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(25)
                        .frame(width: 300, height: 300)
                    Button(action: returnBook) {
                        Text("Вернуть Книжку")
                            .fontWeight(.medium)
                            .font(.title2)
                    }
                } else {
                    Button("Сделайте фото книжки") {
                        self.sourceType = .camera
                        self.isImagePickerDisplay.toggle()
                    }
                    .padding()
                }

            }
            .sheet(isPresented: self.$isImagePickerDisplay) {
                ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
            }
        }
    }
    
    let book: BookResponseModel
    
    let viewModel: UserProfileViewModel

    private func returnBook() {
        viewModel.returnBook(book: book)
    }
}


// MARK: - Image Picker


struct ImagePickerView: UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var isPresented
    var sourceType: UIImagePickerController.SourceType
        
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = self.sourceType
        imagePicker.delegate = context.coordinator // confirming the delegate
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {

    }

    // Connecting the Coordinator class with this struct
    func makeCoordinator() -> PickerCoordinator {
        return PickerCoordinator(picker: self)
    }
}

class PickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: ImagePickerView
    
    init(picker: ImagePickerView) {
        self.picker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        self.picker.selectedImage = selectedImage
        self.picker.isPresented.wrappedValue.dismiss()
    }
    
}

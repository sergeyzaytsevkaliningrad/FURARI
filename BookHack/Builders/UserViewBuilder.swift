//
//  UserViewBuilder.swift
//  BookHack
//
//  Created by Сергей Зайцев on 21.03.2021.
//

import UIKit
import SwiftUI

protocol UserViewBuilderProtocol {
    func makeBookCatalogController(coordinator: UserFlowCoordinatorProtocol) -> UIViewController
    func makeScannerCodeController(coordinator: UserFlowCoordinatorProtocol) -> UIViewController
    func makeBookController(model: BookResponseModel, coordinator: UserFlowCoordinatorProtocol) -> UIViewController
}

final class UserViewBuilder: UserViewBuilderProtocol {
    
    private let networkService: InnerNetworkServiceProtocol
    private let ISBNService: IsbnNetworkServiceProtocol
    
    init(networkService: InnerNetworkServiceProtocol,
         ISBNService: IsbnNetworkServiceProtocol) {
        self.networkService = networkService
        self.ISBNService = ISBNService
    }
    
    func makeBookCatalogController(coordinator: UserFlowCoordinatorProtocol) -> UIViewController {
        let viewModel = CatalogViewModel(networkService: networkService, coordinator: coordinator)
//        let controller = CatalogViewController(viewModel: viewModel)
        
        return UIHostingController(rootView: CatalogSwiftView())
    }
    
    func makeScannerCodeController(coordinator: UserFlowCoordinatorProtocol) -> UIViewController {
        let delegate = ISBNScannerDelegate(ISBNService: ISBNService, firebaseService: networkService, coordinator: coordinator)
        let controller = IsbnScannerViewController(scannerDelegate: delegate)
        return controller
    }
    
    func makeBookController(model: BookResponseModel, coordinator: UserFlowCoordinatorProtocol) -> UIViewController {
        let viewModel = BookViewModel(coordinator: coordinator, networkService: networkService, bookModel: model)
        let view = BookSwiftUIView(viewModel: viewModel)
        let controller = UIHostingController(rootView: view)
        return controller
    }
}

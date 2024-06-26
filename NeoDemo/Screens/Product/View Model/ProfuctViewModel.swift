//
//  ProductViewModel.swift
//  NeoDemo
//
//  Created by Apple on 19/06/24.
//

import Foundation

final class ProductViewModel {
    
    var products: [ProdData] = []
    var eventHandler: ((_ event: Event) -> Void)? //data binding
    
    func fetchProducts(){
        self.eventHandler?(.loading)
        APIManager.shared.fetchProducts{
            response in self.eventHandler?(.stopLoading)
            switch response {
            case .success(let products):
                self.products = products.data
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                print(error)
                self.eventHandler?(.error(error))
            }
        }
    }
}

extension ProductViewModel {
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}

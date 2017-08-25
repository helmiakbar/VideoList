//
//  ProductPresenter.swift
//  iOS-Base
//
//  Created by Lutfi Azhar on 8/24/17.
//  Copyright © 2017 Lutfi Azhar. All rights reserved.
//

import Foundation

struct ProductViewData{
    let productName: String
    let productPrice: Int
}

protocol ProductView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setObject(datas: [ProductViewData])
    func setEmptyObject()
    func setErrorMessageFromAPI(errorMessage: String)
}

class ProductPresenter {
    
    fileprivate let productService : ProductService
    weak fileprivate var productView : ProductView?
    
    init(productService: ProductService) {
        self.productService = productService
    }
    
    func attachView(view: ProductView) {
        self.productView = view
    }
    
    func detachView() {
        self.productView = nil
    }
    
    // MARK: - API Call
    func getProductsAPI() {
        self.productView?.startLoading()
        
        self.productService.getProductsAPI(callBack: { [weak self](datas) in
            
            self?.productView?.finishLoading()
            
            if (datas.count == 0) {
                self?.productView?.setEmptyObject()
            }else {
                let mappedObject = datas.map {
                    return ProductViewData(productName: $0.title!, productPrice: Int($0.price!))
                }
                self?.productView?.setObject(datas: mappedObject)
            }
            
        }) { (message: String) in
            
            self.productView?.finishLoading()
            self.productView?.setEmptyObject()
            self.productView?.setErrorMessageFromAPI(errorMessage: message)
            
        }
        
    }
}

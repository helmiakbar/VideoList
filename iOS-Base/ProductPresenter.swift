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

struct UserViewData{
    let userName: String
    let email: String
}

protocol ProductView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setProduct(datas: [ProductViewData])
    func setUser(data: UserViewData)
    func setEmptyObject()
    func setErrorMessageFromAPI(errorMessage: String)
}

class ProductPresenter {
    
    weak fileprivate var productView : ProductView?
    fileprivate let productService : ProductService
    fileprivate let userService : UserService
    
    init(productService: ProductService, userService: UserService) {
        self.productService = productService
        self.userService = userService
    }
    
    func attachView(view: ProductView) {
        self.productView = view
    }
    
    func detachView() {
        self.productView = nil
    }
    
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
                self?.productView?.setProduct(datas: mappedObject)
            }
            
        }) { (message: String) in
            
            self.productView?.finishLoading()
            self.productView?.setEmptyObject()
            self.productView?.setErrorMessageFromAPI(errorMessage: message)
            
        }
        
    }
    
    func getUserAPI() {
        self.productView?.startLoading()
        
        self.userService.getUserAPI(callBack: { [weak self](data) in
            
            self?.productView?.finishLoading()
            self?.productView?.setUser(data: UserViewData(userName: data.name!, email: data.email!))
            
        }) { (message: String) in
            
            self.productView?.finishLoading()
            self.productView?.setEmptyObject()
            self.productView?.setErrorMessageFromAPI(errorMessage: message)
            
        }
        
    }
}

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
    func getProductsWithAPI() {
        self.productView?.startLoading()
        
        APIManager.sharedInstance.POSTAPIWithResponseObject(route: Constant.RouteProduct,
                                                            parameter: ["page":"0"],
                                                            successBlock: { (responseObject: [String : Any]) in
                                                                
                                                                self.productService.getProducts(datas: responseObject["products"] as! Array<[String:Any]>) { [weak self](datas) in
                                                                    
                                                                    self?.productView?.finishLoading()
                                                                    
                                                                    if (datas.count == 0) {
                                                                        self?.productView?.setEmptyObject()
                                                                    }else {
                                                                        let mappedObject = datas.map {
                                                                            return ProductViewData(productName: $0.productName, productPrice: $0.price)
                                                                        }
                                                                        self?.productView?.setObject(datas: mappedObject)
                                                                    }
                                                                }
                                                                
        }) { (errorMessage: String) in
            
            self.productView?.finishLoading()
            self.productView?.setEmptyObject()
            self.productView?.setErrorMessageFromAPI(errorMessage: errorMessage)
        }
        
        
        
    }
}

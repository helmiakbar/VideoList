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
    func getProductsWithAPI(route: String, errorCallBack: @escaping (_ errorMessage: String) -> Void) {
        self.productView?.startLoading()
        
        APIManager.sharedInstance.POSTAPIWithResponseObject(route: route,
                                                            parameter: ["page":"0"],
                                                            successBlock: { (responseObject: [String : Any]) in
                                                                
                                                                errorCallBack("")
                                                                
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
            
            errorCallBack(errorMessage)
            self.productView?.finishLoading()
            self.productView?.setEmptyObject()
        }
        
        
        
    }
}

//
//  ProductService.swift
//  iOS-Base
//
//  Created by Lutfi Azhar on 8/24/17.
//  Copyright © 2017 Lutfi Azhar. All rights reserved.
//

import Foundation

class ProductService {
    
    func getProductsAPI(callBack: @escaping (Array<Product>) -> Void, message: @escaping (String) -> Void) {
        
        APIManager.sharedInstance.POSTAPIWithResponseObject(route: Constant.RouteProduct,
                                                            parameter: ["page":"0"],
                                                            successBlock: { (responseObject: [String : Any]) in
                                                                
                                                                let datas = responseObject["products"] as! Array<[String:Any]>
                                                                var array: Array<Product> = []
                                                                for data in datas {
                                                                    array.append(Product.init(data: data))
                                                                }
                                                                
                                                                callBack(array)
                                                                
        }) { (errorMessage: String) in
            message(errorMessage)
        }
        
    }
}

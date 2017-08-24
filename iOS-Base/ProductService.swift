//
//  ProductService.swift
//  iOS-Base
//
//  Created by Lutfi Azhar on 8/24/17.
//  Copyright © 2017 Lutfi Azhar. All rights reserved.
//

import Foundation

class ProductService {
    
    func getProducts(datas: Array<[String:Any]>, callBack: @escaping (Array<Product>) -> Void) {
        
        var array: Array<Product> = []
        for data in datas {
            
            let id = data["id"] as? Int ?? nil
            let productName = data["title"] as? String ?? ""
            let description = data["description"] as? String ?? ""
            let price = data["price"] as? Int ?? nil
            
            array.append(Product(id: id!, productName: productName, description: description, price: price!))
        }
        
        let delayTime = DispatchTime.now() + Double(Int64(2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            callBack(array)
        }
        
    }
}

//
//  UserService.swift
//  iOS-Base
//
//  Created by Lutfi Azhar on 8/24/17.
//  Copyright © 2017 Lutfi Azhar. All rights reserved.
//

import Foundation

class UserService {
    
    func getUserAPI(callBack: @escaping (User) -> Void, message: @escaping (String) -> Void) {
        
        APIManager.sharedInstance.POSTAPIWithResponseObject(
            route: Constant.RouteLogin,
            parameter: ["email":"m.lutfiazhar@gmail.com",
                        "password":"password",
                        "device_id":""],
            successBlock: { (responseObject: [String : Any]) in
                
                let user = User.init(data: responseObject)
                callBack(user)
                
        }) { (errorMessage: String) in
            
            message(errorMessage)
            
        }
        
    }
}

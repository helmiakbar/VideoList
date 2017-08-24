//
//  UserService.swift
//  iOS-Base
//
//  Created by Lutfi Azhar on 8/24/17.
//  Copyright © 2017 Lutfi Azhar. All rights reserved.
//

import Foundation

class UserService {
    
    func getUser(data: [String:Any], callBack: @escaping (User) -> Void) {
        
        let id = data["id"] as? Int ?? nil
        let firstName = data["first_name"] as? String ?? ""
        let lastName = data["last_name"] as? String ?? ""
        let email = data["email"] as? String ?? ""
        let age = data["age"] as? Int ?? nil
        
        let user = User(id: id!, firstName: firstName, lastName: lastName, email: email, age: age!)
        
        let delayTime = DispatchTime.now() + Double(Int64(2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            callBack(user)
        }
        
    }
}

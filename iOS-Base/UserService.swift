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
        
        let user = User.init(data: data)
        
        let delayTime = DispatchTime.now() + Double(Int64(2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            callBack(user)
        }
        
    }
}

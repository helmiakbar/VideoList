//
//  UserPresenter.swift
//  iOS-Base
//
//  Created by Lutfi Azhar on 8/24/17.
//  Copyright © 2017 Lutfi Azhar. All rights reserved.
//

import Foundation

struct UserViewData{
    let name: String
    let email: String
}

protocol UserView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setObject(data: UserViewData)
    func setEmptyObject()
}

class UserPresenter {
    
    fileprivate let userService : UserService
    weak fileprivate var userView : UserView?
    fileprivate let data : [String:Any]
    
    init(data: [String:Any], userService: UserService) {
        self.data = data
        self.userService = userService
    }
    
    func attachView(view: UserView) {
        self.userView = view
    }
    
    func detachView() {
        self.userView = nil
    }
    
    func getUser() {
        self.userView?.startLoading()
        
        userService.getUser(data: self.data) { [weak self](data) in
            self?.userView?.finishLoading()
            
            let mappedObject = UserViewData(name: data.name!, email: data.email!)
            self?.userView?.setObject(data: mappedObject)
        }

    }
}

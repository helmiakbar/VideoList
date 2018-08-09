//
//  DataManager.swift
//  iOS-Base
//
//  Created by Lutfi Azhar on 8/24/17.
//  Copyright © 2017 Lutfi Azhar. All rights reserved.
//

import Foundation
import UIKit

class DataManager {
    
    private init() {}
    static let sharedInstance = DataManager()
    
    func isLogin() -> Bool {
        return UserDefaults.standard.object(forKey: "AUTH_TOKEN_USERDEFAULTS") != nil
    }
    
    func clearAllSession() {
        UserDefaults.standard.removeObject(forKey: "USER_ID_USERDEFAULTS")
        UserDefaults.standard.removeObject(forKey: "AUTH_TOKEN_USERDEFAULTS")
        UserDefaults.standard.removeObject(forKey: "USER_DETAIL_USERDEFAULTS")
    }
    
    func setAuthToken(token: String) {
        UserDefaults.standard.set(token, forKey: "AUTH_TOKEN_USERDEFAULTS")
    }
    
    func getAuthToken() -> String {
        return UserDefaults.standard.value(forKey: "AUTH_TOKEN_USERDEFAULTS") as! String
    }
    
    func setUserId(userId: Int) {
        UserDefaults.standard.set(userId, forKey: "USER_ID_USERDEFAULTS")
    }
    
    func getUserId() -> Int {
        return UserDefaults.standard.value(forKey: "USER_ID_USERDEFAULTS") as! Int
    }
    
    func setMovieId(movieId: Int) {
        UserDefaults.standard.set(movieId, forKey: "movieId")
    }
    
    func getMovieId() -> Int {
        return UserDefaults.standard.value(forKey: "movieId") as? Int ?? 0
    }
    
}

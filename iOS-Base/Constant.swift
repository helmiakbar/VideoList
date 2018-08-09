//
//  Constant.swift
//  iOS-Base
//
//  Created by Lutfi Azhar on 8/24/17.
//  Copyright © 2017 Lutfi Azhar. All rights reserved.
//

import UIKit

struct Constant {
    
    private struct Domains {
        static let Development = "http://128.199.91.243"
        static let Production = "https://api.themoviedb.org"
    }
    
    private struct Routes {
        
        static let Movies = "/3/movie/now_playing"
        static let RelatedMovie = "/3/movie"
    }
    
    struct Notification {
        static let googleSignIn = "googleSignInNotification"
    }
    
    static let LocaleIdentifier = "id_ID"
    
    static let BaseURL = Domains.Production
    
    static let RouteGetMoview = Routes.Movies
    static let RouteGetRelatedMovie = Routes.RelatedMovie
    
}

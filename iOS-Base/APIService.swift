//
//  APIService.swift
//  iOS-Base
//
//  Created by Lutfi Azhar on 11/2/17.
//  Copyright © 2017 Lutfi Azhar. All rights reserved.
//

import Foundation

class APIService {
    
    private init() {}
    static let sharedInstance = APIService()
    
    func getMoviesAPI(success: @escaping (Array<Movie>) -> Void, error: @escaping (String) -> Void) {
        
        APIManager.sharedInstance.GETAPIWithResponseObject(
            route: Constant.RouteGetMoview + "?api_key=27d1b110362231ee861826f428440e1a&language=en-US&page=1",
            successBlock: { (responseObject: [String : Any]) in
                let datas = responseObject["results"] as! Array<[String:Any]>
                var array: Array<Movie> = []
                for data in datas {
                    array.append(Movie.init(data: data))
                }
                success(array)
                
        }) { (errorMessage: String) in
            error(errorMessage)
        }
    }
    
    func getRelatedMovieAPI(success: @escaping (Array<Movie>) -> Void, error: @escaping (String) -> Void) {
        let movieId = String(DataManager.sharedInstance.getMovieId())
        APIManager.sharedInstance.GETAPIWithResponseObject(
            route: Constant.RouteGetRelatedMovie + "/\(movieId)/similar?api_key=27d1b110362231ee861826f428440e1a&language=en-US&page=1",
            successBlock: { (responseObject: [String : Any]) in
                let datas = responseObject["results"] as! Array<[String:Any]>
                var array: Array<Movie> = []
                for data in datas {
                    array.append(Movie.init(data: data))
                }
                success(array)
                
        }) { (errorMessage: String) in
            error(errorMessage)
        }
    }
}

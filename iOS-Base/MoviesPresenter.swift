//
//  MoviesPresenter.swift
//  iOS-Base
//
//  Created by Helmi Akbar on 09/08/18.
//  Copyright © 2018 Lutfi Azhar. All rights reserved.
//

import Foundation

struct MovieViewData {
    let movieId: Int
    let movieTitle: String
    let moviePosterPath: String
    let movieReleaseDate: String
    let movieOverview: String
}

protocol MovieView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setMovie(datas: [MovieViewData])
    func setEmptyObject()
    func setErrorMessageFromAPI(errorMessage: String)
}

class MoviePresenter {
    weak fileprivate var movieView : MovieView?
    
    private init() {}
    static let sharedInstance = MoviePresenter()
    
    func attachView(view: MovieView) {
        self.movieView = view
    }
    
    func detachView() {
        self.movieView = nil
    }
    
    func getMovieAPI() {
        self.movieView?.startLoading()
        
        APIService.sharedInstance.getMoviesAPI(success: { [weak self](datas) in
            
            self?.movieView?.finishLoading()
            
            if (datas.count == 0) {
                self?.movieView?.setEmptyObject()
            } else {
                let mappedObject = datas.map {
                    return MovieViewData(movieId: $0.id!, movieTitle: $0.title!, moviePosterPath: $0.poster_path!, movieReleaseDate: $0.release_date!, movieOverview: $0.overview!)
                }
                self?.movieView?.setMovie(datas: mappedObject)
            }
            
        }) { (message: String) in
            
            self.movieView?.finishLoading()
            self.movieView?.setEmptyObject()
            self.movieView?.setErrorMessageFromAPI(errorMessage: message)
            
        }
        
    }
}

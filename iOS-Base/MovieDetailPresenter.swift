//
//  MovieDetailPresenter.swift
//  iOS-Base
//
//  Created by Helmi Akbar on 10/08/18.
//  Copyright © 2018 Lutfi Azhar. All rights reserved.
//

import Foundation


struct MovieDetailViewData {
    let movieId: Int
    let movieTitle: String
    let moviePosterPath: String
    let movieReleaseDate: String
    let movieOverview: String
}

protocol MovieDetailView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setMovie(datas: [MovieDetailViewData])
    func setEmptyObject()
    func setErrorMessageFromAPI(errorMessage: String)
}

class MovieDetailPresenter {
    weak fileprivate var movieDetailView : MovieDetailView?
    
    private init() {}
    static let sharedInstance = MovieDetailPresenter()
    
    func attachView(view: MovieDetailView) {
        self.movieDetailView = view
    }
    
    func detachView() {
        self.movieDetailView = nil
    }
    
    func getRelatedMovieAPI() {
        self.movieDetailView?.startLoading()
        
        APIService.sharedInstance.getRelatedMovieAPI(success: { [weak self](datas) in
            
            self?.movieDetailView?.finishLoading()
            
            if (datas.count == 0) {
                self?.movieDetailView?.setEmptyObject()
            } else {
                let mappedObject = datas.map {
                    return MovieDetailViewData(movieId: $0.id!, movieTitle: $0.title!, moviePosterPath: $0.poster_path!, movieReleaseDate: $0.release_date!, movieOverview: $0.overview!)
                }
                self?.movieDetailView?.setMovie(datas: mappedObject)
            }
            
        }) { (message: String) in
            
            self.movieDetailView?.finishLoading()
            self.movieDetailView?.setEmptyObject()
            self.movieDetailView?.setErrorMessageFromAPI(errorMessage: message)
            
        }
        
    }
}

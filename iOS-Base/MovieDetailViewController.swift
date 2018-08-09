//
//  MovieDetailViewController.swift
//  iOS-Base
//
//  Created by Helmi Akbar on 09/08/18.
//  Copyright © 2018 Lutfi Azhar. All rights reserved.
//

import UIKit
import Kingfisher

class MovieDetailViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MovieDetailView {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitleLbl: UILabel!
    @IBOutlet weak var movieReleaseDateLbl: UILabel!
    @IBOutlet weak var movieOverviewLbl: UILabel!
    
    @IBOutlet weak var relatedMovieCollection: UICollectionView!
    
    fileprivate var moviesToDisplay = [MovieDetailViewData]()
    
    var movieId: Int!
    var moviePoster: String!
    var movieTitle: String!
    var movieReleaseDate: String!
    var movieOverview: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageUrl = self.moviePoster
        let imagePath = "https://image.tmdb.org/t/p/w500\(imageUrl ?? "")"
        
        if imagePath != "" {
            let resourceImage = ImageResource(downloadURL: URL(string: imagePath)!, cacheKey: imagePath)
            self.movieImage.kf.setImage(with:resourceImage, options: [.forceRefresh])
        } else {
            self.movieImage.image = UIImage.init(named: "img-profile-placeholder")
        }

        self.movieTitleLbl.text = self.movieTitle
        self.movieReleaseDateLbl.text = self.movieReleaseDate
        self.movieOverviewLbl.text = self.movieOverview
        
        DataManager.sharedInstance.setMovieId(movieId: self.movieId)
        
        MovieDetailPresenter.sharedInstance.attachView(view: self)
        MovieDetailPresenter.sharedInstance.getRelatedMovieAPI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - PresenterDelagte
    func startLoading() {
        self.showLoadingIndicator()
    }
    
    func finishLoading() {
        self.hideLoadingIndicator()
    }
    
    func setMovie(datas: [MovieDetailViewData]) {
        self.moviesToDisplay = datas
        self.relatedMovieCollection?.reloadData()
    }
    
    func setEmptyObject() {
        self.hideLoadingIndicator()
    }
    
    func setErrorMessageFromAPI(errorMessage: String) {
        self.basicAlertView(title: "", message: errorMessage, successBlock: {})
    }
    
    // MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.moviesToDisplay.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! MoviesCollectionViewCell
        
        let movie = self.moviesToDisplay[indexPath.row]
        
        let imageUrl = movie.moviePosterPath
        let imagePath = "https://image.tmdb.org/t/p/w500\(imageUrl)"
        
        if imagePath != "" {
            let resourceImage = ImageResource(downloadURL: URL(string: imagePath)!, cacheKey: imagePath)
            cell.moviePosterImageView.kf.setImage(with:resourceImage, options: [.forceRefresh])
        } else {
            cell.moviePosterImageView.image = UIImage.init(named: "img-profile-placeholder")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = self.moviesToDisplay[indexPath.row]
        self.movieId = movie.movieId
        self.moviePoster = movie.moviePosterPath
        self.movieTitle = movie.movieTitle
        self.movieReleaseDate = movie.movieReleaseDate
        self.movieOverview = movie.movieOverview
        self.viewDidLoad()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.relatedMovieCollection.frame.width/2.5, height:self.relatedMovieCollection.frame.height)
    }

}

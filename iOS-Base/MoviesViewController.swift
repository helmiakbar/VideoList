//
//  MoviesViewController.swift
//  iOS-Base
//
//  Created by Helmi Akbar on 08/08/18.
//  Copyright © 2018 Lutfi Azhar. All rights reserved.
//

import UIKit
import Kingfisher

class MoviesViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MovieView {
    
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    fileprivate var moviesToDisplay = [MovieViewData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.moviesTableView.isHidden = false
        self.moviesCollectionView.isHidden = true
        
        MoviePresenter.sharedInstance.attachView(view: self)
        MoviePresenter.sharedInstance.getMovieAPI()
        
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
    
    func setMovie(datas: [MovieViewData]) {
        self.moviesToDisplay = datas
        self.moviesTableView?.reloadData()
        self.moviesCollectionView?.reloadData()
    }
    
    func setEmptyObject() {
        self.hideLoadingIndicator()
    }
    
    func setErrorMessageFromAPI(errorMessage: String) {
        self.basicAlertView(title: "", message: errorMessage, successBlock: {})
    }
    
    //MARK: - ButtonAction
    @IBAction func listBtn(_ sender: Any) {
        self.moviesTableView.isHidden = false
        self.moviesCollectionView.isHidden = true
    }
    
    @IBAction func gridBtn(_ sender: Any) {
        self.moviesTableView.isHidden = true
        self.moviesCollectionView.isHidden = false
    }
    
    // MARK: - UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.moviesToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MoviesTableViewCell
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "movieDetail", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height/2.1
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
        self.performSegue(withIdentifier: "movieDetail", sender: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.moviesCollectionView.frame.width/2, height:self.view.frame.height/2.5)
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movieDetail" {
            let detail = segue.destination as! MovieDetailViewController
            let idx = sender as! IndexPath
            let movie = self.moviesToDisplay[idx.row]
            detail.movieId = movie.movieId
            detail.moviePoster = movie.moviePosterPath
            detail.movieTitle = movie.movieTitle
            detail.movieReleaseDate = movie.movieReleaseDate
            detail.movieOverview = movie.movieOverview
        }
    }
}

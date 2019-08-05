//
//  MovieDetailTableViewContoller.swift
//  movieDB
//
//  Created by Kasım on 4.08.2019.
//  Copyright © 2019 KS. All rights reserved.
//

import UIKit
import Cosmos
import PKHUD
import AVFoundation

class MovieDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var posterImage: MovieImageView!
    @IBOutlet weak var backPoster: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var kindOfMovieLabel: UILabel!
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var castCollectionView: UICollectionView!
    @IBOutlet weak var videoButton: UIButton!
    
    var movie: Movie?
    var movieDetail: MovieDetail?{
        didSet{
            setUI()
            if let genres = movieDetail?.genres {
                genreString = ""
                for item in genres {
                    genreString = "\(genreString!), \(item.name!)"
                }
                genreString?.removeFirst()
                genreString?.removeFirst()
            }
            videoButton.isHidden = !(movieDetail?.video ?? false)
        }
    }
    var genreString: String? {
        didSet{
            kindOfMovieLabel.text = genreString
        }
    }
    var moviesCast = [Cast](){
        didSet {
            castCollectionView.reloadData()
        }
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getDetails(movie?.id ?? 0)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "share"), style: .done, target: self, action: #selector(share))
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = UIColor.white
    }
    
    @IBAction func showVideoAction(_ sender: Any) {
        let url = URL(string: "movie video linki gelmiyor!!") // TODO - video linki gelmiyor!!
        let playerItem = AVPlayerItem(url: url!)
        let player = AVPlayer(playerItem: playerItem)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.frame
        self.view.layer.addSublayer(playerLayer)
    }
    
    @objc func share(){
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [movie?.original_title ?? "", movieDetail?.homepage ?? "", movie?.release_date ?? ""], applicationActivities: nil)
        
        // This line remove the arrow of the popover to show in iPad
        activityViewController.popoverPresentationController?.permittedArrowDirections = .any
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
        
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func setUI(){
        backPoster.kf.setImage(with: URL(string: Constants.imageUrl + (movieDetail?.backdrop_path ?? "")), placeholder: nil, options: [.cacheOriginalImage], progressBlock: nil) { (image, error, _, _) in
            if let image = image {
                self.backgroundView.backgroundColor = image.averageColor
            }
        }
        posterImage.kf.setImage(with: URL(string: Constants.imageUrl + (movieDetail?.poster_path ?? "")), placeholder: nil, options: [.cacheOriginalImage] , progressBlock: nil, completionHandler: nil)
        
        descriptionLabel.text = movieDetail?.overview
        titleLabel.text = movieDetail?.original_title
        rateLabel.text = String(describing: movieDetail?.vote_average ?? 0.0)
        
        cosmosView.rating = (self.movieDetail?.vote_average ?? 0.0)/2
        cosmosView.settings.fillMode = .precise
    }
    
    func getDetails(_ movieId : Int) {
        PKHUD.sharedHUD.show()
        MainService.shared.getMovieDetail(movieId, completion: {(movieDetailResponse, error) in
            PKHUD.sharedHUD.hide()
            if error == nil {
                self.movieDetail = movieDetailResponse
                self.getCast(movieId)
            }else {
                ViewUtils.showAlert(withController: self, title: Utils.localized("alert_title_error"), message: error)
            }
        })
    }
    
    func getCast(_ movieId : Int) {
        MainService.shared.getMovieCast(movieId, completion: {(creditsResponse, error) in
            if error == nil {
                self.moviesCast = creditsResponse?.cast ?? []
            }else {
                ViewUtils.showAlert(withController: self, title: Utils.localized("alert_title_error"), message: error)
            }
        })
    }
}

extension MovieDetailTableViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesCast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.register(UINib(nibName: "CastCollectionCell", bundle: nil), forCellWithReuseIdentifier: "CastCollectionCell")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCollectionCell", for: indexPath) as! CastCollectionCell
        
        cell.castCollectionImageView.kf.setImage(with: URL(string: Constants.imageUrl+(moviesCast[indexPath.row].profile_path ?? "")), placeholder: nil, options: [.cacheOriginalImage], progressBlock: nil,completionHandler: nil)
        cell.castCollectionNameLabel.text = self.moviesCast[indexPath.row].name ?? ""
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) ->
        CGSize {
            let width = collectionView.frame.width/3
            let height = collectionView.frame.height-8
            return CGSize(width: width, height: height)
    }
}

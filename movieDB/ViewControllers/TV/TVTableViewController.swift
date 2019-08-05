//
//  TVTableViewController.swift
//  movieDB
//
//  Created by Kasım on 4.08.2019.
//  Copyright © 2019 KS. All rights reserved.
//

import UIKit
import PKHUD
import Kingfisher

class TVTableViewController: UITableViewController {
    
    @IBOutlet weak var topRatedCollectionView: UICollectionView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var popularCollectionViewHeight: NSLayoutConstraint!
    
    let sectionTitles = ["Latest", "Popular TV Shows"]
    var topRatedMovies: [TV] = [] {
        didSet{
            topRatedCollectionView.reloadData()
        }
    }
    var popularMovies: [TV] = [] {
        didSet{
            popularCollectionView.reloadData()
            tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getMovieData()
    }
    
    func getMovieData() {
        PKHUD.sharedHUD.show()
        MainService.shared.getTopRatedTV(completion: {(movies, error) in
            PKHUD.sharedHUD.hide()
            if error == nil {
                self.topRatedMovies = movies ?? []
            }else {
                ViewUtils.showAlert(withController: self, title: Utils.localized("alert_title_error"), message: error)
            }
        })
        
        MainService.shared.getPopularTV(completion: {(movies, error) in
            PKHUD.sharedHUD.hide()
            if error == nil {
                self.popularMovies = movies ?? []
            }else {
                ViewUtils.showAlert(withController: self, title: Utils.localized("alert_title_error"), message: error)
            }
        })
    }
    
    // TABLEVIEW DELEGATE FUNCS
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40))
        view.backgroundColor = .white
        let label = UILabel(frame: CGRect(x: 16, y: 10, width: self.view.frame.width-16, height: 40))
        
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor.darkGray
        label.text = sectionTitles[section]
        
        view.addSubview(label)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 270
        case 1:
            return UITableView.automaticDimension
        default:
            return 0
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

extension TVTableViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // COLLECTIONVIEW DELEGATE FUNCS
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case topRatedCollectionView:
            return topRatedMovies.count
        case popularCollectionView:
            return popularMovies.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case topRatedCollectionView:
            
            collectionView.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
            
            cell.movieImageView.kf.setImage(with: URL(string: Constants.imageUrl+(topRatedMovies[indexPath.row].poster_path ?? "")), placeholder: nil, options: [.cacheOriginalImage], progressBlock: nil, completionHandler: nil)
            cell.movieLabel.text = topRatedMovies[indexPath.row].original_name
            
            return cell
            
        case popularCollectionView:
            collectionView.register(UINib(nibName: "PopularTVShowCell", bundle: nil), forCellWithReuseIdentifier: "PopularTVShowCell")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularTVShowCell", for: indexPath) as! PopularTVShowCell
            
            cell.movieImageView.kf.setImage(with: URL(string: Constants.imageUrl+(popularMovies[indexPath.row].poster_path ?? "")), placeholder: nil, options: [.cacheOriginalImage], progressBlock: nil, completionHandler: nil)
            cell.movieLabel.text = popularMovies[indexPath.row].original_name ?? ""+"\(String(describing: popularMovies[indexPath.row].first_air_date))"
            cell.movieRateLabel.text = String(format:"%.1f", popularMovies[indexPath.row].vote_average ?? 0.0)
            
            popularCollectionViewHeight.constant = collectionView.contentSize.height
            self.tableView.reloadData()
            
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) ->
        CGSize {
            switch collectionView {
            case topRatedCollectionView:
                
                let width = 180
                let height = 270
                return CGSize(width: width, height: height)
                
            case popularCollectionView:
                
                let width = self.view.frame.width
                let height = width*2/3
                return CGSize(width: width, height: height)
                
            default:
                return CGSize.zero
                
            }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "TVDetailTableViewController") as! TVDetailTableViewController
        switch collectionView {
        case topRatedCollectionView:
            vc.tv = topRatedMovies[indexPath.row]
        case popularCollectionView:
            vc.tv = popularMovies[indexPath.row]
        default: break
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

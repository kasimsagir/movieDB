//
//  MovieCell.swift
//  movieDB
//
//  Created by Kasım on 1.08.2019.
//  Copyright © 2019 KS. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImageView: MovieImageView!
    @IBOutlet weak var movieLabel: UILabel!
    
    override func awakeFromNib() {
        movieImageView.layer.cornerRadius = 16
        movieImageView.layer.shadowColor = UIColor.black.cgColor
        movieImageView.layer.shadowRadius = 5
        movieImageView.layer.shadowOpacity = 10
        movieImageView.layer.shadowOffset = CGSize(width: 0, height: 5)
        movieImageView.layer.masksToBounds = true
        movieImageView.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
}

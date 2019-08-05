//
//  CastCollectionCell.swift
//  movieDB
//
//  Created by Kasım on 4.08.2019.
//  Copyright © 2019 KS. All rights reserved.
//

import UIKit

class CastCollectionCell: UICollectionViewCell {
    @IBOutlet weak var castCollectionImageView: MovieImageView!
    @IBOutlet weak var castCollectionNameLabel: UILabel!
    @IBOutlet weak var castView: UIView!
    
    override func awakeFromNib() {
        castView.layer.cornerRadius = 10
        castView.layer.shadowColor = UIColor.black.cgColor
        castView.layer.shadowOffset = CGSize(width: 0, height: 2)
        castView.layer.shadowOpacity = 0.2
        castView.layer.shadowRadius = 5
        
        
        castCollectionImageView.layer.cornerRadius = 16
        castCollectionImageView.clipsToBounds = true
    }
}

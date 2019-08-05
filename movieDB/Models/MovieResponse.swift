//
//  Movie.swift
//  movieDB
//
//  Created by Kasım on 2.08.2019.
//  Copyright © 2019 KS. All rights reserved.
//

import Foundation

class MovieResponse : BaseCodable {
    let movies : [Movie]?
    let page : Int?
    let total_results : Int?
    let dates : Dates?
    let total_pages : Int?
    
    private enum CodingKeys: String, CodingKey {
        case movies = "results"
        case page = "page"
        case total_results = "total_results"
        case dates = "dates"
        case total_pages = "total_pages"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        movies = try values.decodeIfPresent([Movie].self, forKey: .movies)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        total_results = try values.decodeIfPresent(Int.self, forKey: .total_results)
        dates = try values.decodeIfPresent(Dates.self, forKey: .dates)
        total_pages = try values.decodeIfPresent(Int.self, forKey: .total_pages)
        
        try super.init(from: decoder)
    }
    
}

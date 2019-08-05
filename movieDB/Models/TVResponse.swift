//
//  TVResponse.swift
//  movieDB
//
//  Created by Kasım on 4.08.2019.
//  Copyright © 2019 KS. All rights reserved.
//

import Foundation

class TVResponse : BaseCodable {
    let page : Int?
    let total_results : Int?
    let total_pages : Int?
    let results : [TV]?
    
    enum CodingKeys: String, CodingKey {
        
        case page = "page"
        case total_results = "total_results"
        case total_pages = "total_pages"
        case results = "results"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        total_results = try values.decodeIfPresent(Int.self, forKey: .total_results)
        total_pages = try values.decodeIfPresent(Int.self, forKey: .total_pages)
        results = try values.decodeIfPresent([TV].self, forKey: .results)
        
        try super.init(from: decoder)
    }
    
}

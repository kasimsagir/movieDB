//
//  TVCreditsResponse.swift
//  movieDB
//
//  Created by Kasım on 4.08.2019.
//  Copyright © 2019 KS. All rights reserved.
//

import Foundation

class TVCreditsResponse : BaseCodable {
    let cast : [TVCast]?
    let id : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case cast = "cast"
        case crew = "crew"
        case id = "id"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cast = try values.decodeIfPresent([TVCast].self, forKey: .cast)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        
        try super.init(from: decoder)
    }
    
}

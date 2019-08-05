//
//  TV.swift
//  movieDB
//
//  Created by Kasım on 4.08.2019.
//  Copyright © 2019 KS. All rights reserved.
//

import Foundation

struct TV : Codable {
    let original_name : String?
    let genre_ids : [Int]?
    let name : String?
    let popularity : Double?
    let origin_country : [String]?
    let vote_count : Int?
    let first_air_date : String?
    let backdrop_path : String?
    let original_language : String?
    let id : Int?
    let vote_average : Double?
    let overview : String?
    let poster_path : String?
    
    enum CodingKeys: String, CodingKey {
        
        case original_name = "original_name"
        case genre_ids = "genre_ids"
        case name = "name"
        case popularity = "popularity"
        case origin_country = "origin_country"
        case vote_count = "vote_count"
        case first_air_date = "first_air_date"
        case backdrop_path = "backdrop_path"
        case original_language = "original_language"
        case id = "id"
        case vote_average = "vote_average"
        case overview = "overview"
        case poster_path = "poster_path"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        original_name = try values.decodeIfPresent(String.self, forKey: .original_name)
        genre_ids = try values.decodeIfPresent([Int].self, forKey: .genre_ids)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        popularity = try values.decodeIfPresent(Double.self, forKey: .popularity)
        origin_country = try values.decodeIfPresent([String].self, forKey: .origin_country)
        vote_count = try values.decodeIfPresent(Int.self, forKey: .vote_count)
        first_air_date = try values.decodeIfPresent(String.self, forKey: .first_air_date)
        backdrop_path = try values.decodeIfPresent(String.self, forKey: .backdrop_path)
        original_language = try values.decodeIfPresent(String.self, forKey: .original_language)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        vote_average = try values.decodeIfPresent(Double.self, forKey: .vote_average)
        overview = try values.decodeIfPresent(String.self, forKey: .overview)
        poster_path = try values.decodeIfPresent(String.self, forKey: .poster_path)
    }
    
}

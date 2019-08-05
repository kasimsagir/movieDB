//
//  TVCast.swift
//  movieDB
//
//  Created by Kasım on 4.08.2019.
//  Copyright © 2019 KS. All rights reserved.
//

import Foundation

struct TVCast : Codable {
    let character : String?
    let credit_id : String?
    let id : Int?
    let name : String?
    let gender : Int?
    let profile_path : String?
    let order : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case character = "character"
        case credit_id = "credit_id"
        case id = "id"
        case name = "name"
        case gender = "gender"
        case profile_path = "profile_path"
        case order = "order"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        character = try values.decodeIfPresent(String.self, forKey: .character)
        credit_id = try values.decodeIfPresent(String.self, forKey: .credit_id)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        gender = try values.decodeIfPresent(Int.self, forKey: .gender)
        profile_path = try values.decodeIfPresent(String.self, forKey: .profile_path)
        order = try values.decodeIfPresent(Int.self, forKey: .order)
    }
    
}

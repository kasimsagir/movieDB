//
//  BaseCodable.swift
//  movieDB
//
//  Created by Kasım on 2.08.2019.
//  Copyright © 2019 KS. All rights reserved.
//

import Foundation

class BaseCodable : Codable {
    
    /// ERROR RESPONSE
    let status_code : Int?
    let status_message : String?
    let success : Bool?
    
    private enum CodingKeys: String, CodingKey {
        
        case status_code = "status_code"
        case status_message = "status_message"
        case success = "success"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status_code = try values.decodeIfPresent(Int.self, forKey: .status_code)
        status_message = try values.decodeIfPresent(String.self, forKey: .status_message)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        
    }
    
}

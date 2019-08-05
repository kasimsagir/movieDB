//
//  Constants.swift
//  movieDB
//
//  Created by Kasım on 2.08.2019.
//  Copyright © 2019 KS. All rights reserved.
//

import UIKit

@objc public class Constants: NSObject {
    
    /// Base URL
    static let baseUrl = "https://api.themoviedb.org/3"
    /// Base ImageURL
    static let imageUrl = "https://image.tmdb.org/t/p/w500"
    
    /// MovieDB API KEY
    static let apiKey = "76f71fe5435fa9d01ed825a7acf5cf40"
    
    /// Vendor ID - devices unique id
    static var udid = UIDevice.current.identifierForVendor!.uuidString
    
    /// Base Path Func
    static func getPath(_ path: String)-> String {
        return baseUrl+path+"?api_key=\(apiKey)"
    }
    
    /// Service Paths
    static func getMovieTopRatedPath()-> String {
        return Constants.getPath("/movie/top_rated")
    }
    
    static func getTVTopRatedPath()-> String {
        return Constants.getPath("/tv/top_rated")
    }
    
    static func getMovieNowPlayingPath()-> String {
        return Constants.getPath("/movie/now_playing")
    }
    
    static func getMoviePopularPath()-> String {
        return Constants.getPath("/movie/popular")
    }
    
    static func getTVPopularPath()-> String {
        return Constants.getPath("/tv/popular")
    }
    
    static func getMovieDetailPath(_ movieId: Int)-> String {
        return Constants.getPath("/movie/\(movieId)")
    }
    
    static func getTVDetailPath(_ movieId: Int)-> String {
        return Constants.getPath("/tv/\(movieId)")
    }
    
    static func getMovieCreditsPath(_ movieId: Int)-> String {
        return Constants.getPath("/movie/\(movieId)/credits")
    }
    
    static func getTVCreditsPath(_ movieId: Int)-> String {
        return Constants.getPath("/tv/\(movieId)/credits")
    }
    
    /// Default Request Headers
    static func getDefaultHeaders()-> [String:String] {
        return [
            "Content-Type": "application/json",
            "udid": Constants.udid,
        ]
    }
}

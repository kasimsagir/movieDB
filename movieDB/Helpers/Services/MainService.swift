//
//  MainService.swift
//  movieDB
//
//  Created by Kasım on 2.08.2019.
//  Copyright © 2019 KS. All rights reserved.
//

import Alamofire
import SwiftyJSON

class MainService: NSObject {
    
    static let shared: MainService = {
        let instance = MainService()
        return instance
    }()
    
    // MOVIE SERVICES
    /// Get Top Rated Movies
    func getTopRatedMovies(completion: @escaping(_: [Movie]?, _: String?) -> ()) {
        NetworkManager.sharedInstance.request(url: Constants.getMovieTopRatedPath(), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil) { code, responseJSON, error in
            if error == nil {
                do {
                    if let json = try responseJSON?.rawData() {
                        let response = try! JSONDecoder().decode(MovieResponse.self, from: json)
                        completion(response.movies, response.status_message ?? nil)
                    } else {
                        completion(nil, "Sunucuda bir hata oluştu.")
                    }
                }catch {
                    completion(nil, "Bir hata oluştu.")
                }
            }else {
                completion(nil, (error?.localizedDescription)!)
            }
        }
    }
    
    /// Get Popular Movies
    func getPopularMovies(completion: @escaping(_: [Movie]?, _: String?) -> ()) {
        NetworkManager.sharedInstance.request(url: Constants.getMoviePopularPath(), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil) { code, responseJSON, error in
            if error == nil {
                do {
                    if let json = try responseJSON?.rawData() {
                        let response = try! JSONDecoder().decode(MovieResponse.self, from: json)
                        completion(response.movies, response.status_message ?? nil)
                    } else {
                        completion(nil, "Sunucuda bir hata oluştu.")
                    }
                }catch {
                    completion(nil, "Bir hata oluştu.")
                }
            }else {
                completion(nil, (error?.localizedDescription)!)
            }
        }
    }
    
    /// Get Now Playing Movies
    func getNowPlayingMovies(completion: @escaping(_: [Movie]?, _: String?) -> ()) {
        NetworkManager.sharedInstance.request(url: Constants.getMovieNowPlayingPath(), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil) { code, responseJSON, error in
            if error == nil {
                do {
                    if let json = try responseJSON?.rawData() {
                        let response = try! JSONDecoder().decode(MovieResponse.self, from: json)
                        completion(response.movies, response.status_message ?? nil)
                    } else {
                        completion(nil, "Sunucuda bir hata oluştu.")
                    }
                }catch {
                    completion(nil, "Bir hata oluştu.")
                }
            }else {
                completion(nil, (error?.localizedDescription)!)
            }
        }
    }
    
    /// Get Movie Detail
    func getMovieDetail(_ movieId: Int, completion: @escaping(_: MovieDetail?, _: String?) -> ()) {
        NetworkManager.sharedInstance.request(url: Constants.getMovieDetailPath(movieId), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil) { code, responseJSON, error in
            if error == nil {
                do {
                    if let json = try responseJSON?.rawData() {
                        let response = try! JSONDecoder().decode(MovieDetail.self, from: json)
                        completion(response, response.status_message ?? nil)
                    } else {
                        completion(nil, "Sunucuda bir hata oluştu.")
                    }
                }catch {
                    completion(nil, "Bir hata oluştu.")
                }
            }else {
                completion(nil, (error?.localizedDescription)!)
            }
        }
    }
    
    /// Get Movie Cast
    func getMovieCast(_ movieId: Int, completion: @escaping(_: CreditsResponse?, _: String?) -> ()) {
        NetworkManager.sharedInstance.request(url: Constants.getMovieCreditsPath(movieId), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil) { code, responseJSON, error in
            if error == nil {
                do {
                    if let json = try responseJSON?.rawData() {
                        let response = try! JSONDecoder().decode(CreditsResponse.self, from: json)
                        completion(response, response.status_message ?? nil)
                    } else {
                        completion(nil, "Sunucuda bir hata oluştu.")
                    }
                }catch {
                    completion(nil, "Bir hata oluştu.")
                }
            }else {
                completion(nil, (error?.localizedDescription)!)
            }
        }
    }
    
    // TV SERVICES
    /// Get Top Rated TV
    func getTopRatedTV(completion: @escaping(_: [TV]?, _: String?) -> ()) {
        NetworkManager.sharedInstance.request(url: Constants.getTVTopRatedPath(), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil) { code, responseJSON, error in
            if error == nil {
                do {
                    if let json = try responseJSON?.rawData() {
                        let response = try! JSONDecoder().decode(TVResponse.self, from: json)
                        completion(response.results, response.status_message ?? nil)
                    } else {
                        completion(nil, "Sunucuda bir hata oluştu.")
                    }
                }catch {
                    completion(nil, "Bir hata oluştu.")
                }
            }else {
                completion(nil, (error?.localizedDescription)!)
            }
        }
    }
    
    /// Get Popular TV
    func getPopularTV(completion: @escaping(_: [TV]?, _: String?) -> ()) {
        NetworkManager.sharedInstance.request(url: Constants.getTVPopularPath(), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil) { code, responseJSON, error in
            if error == nil {
                do {
                    if let json = try responseJSON?.rawData() {
                        let response = try! JSONDecoder().decode(TVResponse.self, from: json)
                        completion(response.results, response.status_message ?? nil)
                    } else {
                        completion(nil, "Sunucuda bir hata oluştu.")
                    }
                }catch {
                    completion(nil, "Bir hata oluştu.")
                }
            }else {
                completion(nil, (error?.localizedDescription)!)
            }
        }
    }
    
    /// Get TV Detail
    func getTVDetail(_ movieId: Int, completion: @escaping(_: TVDetail?, _: String?) -> ()) {
        NetworkManager.sharedInstance.request(url: Constants.getTVDetailPath(movieId), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil) { code, responseJSON, error in
            if error == nil {
                do {
                    if let json = try responseJSON?.rawData() {
                        let response = try! JSONDecoder().decode(TVDetail.self, from: json)
                        completion(response, response.status_message ?? nil)
                    } else {
                        completion(nil, "Sunucuda bir hata oluştu.")
                    }
                }catch {
                    completion(nil, "Bir hata oluştu.")
                }
            }else {
                completion(nil, (error?.localizedDescription)!)
            }
        }
    }
    
    /// Get TV Cast
    func getTVCast(_ movieId: Int, completion: @escaping(_: TVCreditsResponse?, _: String?) -> ()) {
        NetworkManager.sharedInstance.request(url: Constants.getTVCreditsPath(movieId), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil) { code, responseJSON, error in
            if error == nil {
                do {
                    if let json = try responseJSON?.rawData() {
                        let response = try! JSONDecoder().decode(TVCreditsResponse.self, from: json)
                        completion(response, response.status_message ?? nil)
                    } else {
                        completion(nil, "Sunucuda bir hata oluştu.")
                    }
                }catch {
                    completion(nil, "Bir hata oluştu.")
                }
            }else {
                completion(nil, (error?.localizedDescription)!)
            }
        }
    }
}

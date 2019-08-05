//
//  Utils.swift
//  movieDB
//
//  Created by Kasım on 2.08.2019.
//  Copyright © 2019 KS. All rights reserved.
//

import Alamofire

class Utils {
    
    static func printResponse(response: DataResponse<Any>){
        print("\n\n >>Response : (\(response.request?.url!.relativePath ?? ""))")
        //print(response.request!)  // original URL request
        print(response.response ?? "response.response nil") // URL response
        print(" >>Response Time : "+response.timeline.totalDuration.description)     // server data
        print(" >>Result : ")
        print(response.result)   // result of response serialization
        print(response.result.value ?? "response.result.value yazılamadı.")
        print("\n\n")
    }
    
    static func getAuthorizationKey()-> String {
        return UserDefaults.standard.string(forKey: "registrationSecret") ?? ""
    }
    
    static func localized(_ string: String)-> String{
        return NSLocalizedString(string, comment: "")
    }
}

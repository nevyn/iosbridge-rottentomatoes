//
//  Movie.swift
//  RottenTomatoesSwift
//
//  Created by Jeffrey Bergier on 9/12/15.
//  Copyright © 2015 MobileBridge. All rights reserved.
//

import Foundation

struct Movie {
    let title: String
    let description: String
    let posterURL: NSURL
}

extension Movie {
    static func moviesFromDictionaryArray(dictionaryArray: [NSDictionary]) -> [Movie]? {
        var movieArray = [Movie]()
        
        for dictionary in dictionaryArray {
            if let posterDictionary = dictionary["posters"] as? NSDictionary,
                let posterURLString = posterDictionary["thumbnail"] as? String,
                let posterURL = NSURL(string: posterURLString) {
                    
                    let movieTitle = dictionary["title"] as? String ?? "Title Not Found"
                    let movieDescription = dictionary["synopsis"] as? String ?? "Synopsys Not Found"
                    
                    movieArray += [Movie(title: movieTitle, description: movieDescription, posterURL: posterURL)]
            }
        }
        
        if movieArray.isEmpty == false {
            return movieArray
        } else {
            return .None
        }
    }
}










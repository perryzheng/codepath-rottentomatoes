//
//  Movie.swift
//  rottentomamotes
//
//  Created by Perry Zheng on 9/23/14.
//  Copyright (c) 2014 Perry Zheng. All rights reserved.
//

import Foundation

public class Movie {
    var title = String()
    var synopsis = String()
    var thumbnailPosterUrl = String()
    var originalPosterUrl = String()
    
    var mpaaRating = String()
    var criticsScore = Int()
    var audienceScore = Int()
    var year = Int()
    
    init() {
    }
    
    func initWithDictionary(movie: NSDictionary) {
        title = movie["title"] as String
        synopsis = movie["synopsis"] as String
        thumbnailPosterUrl = movie["posters"]!["thumbnail"] as String
        originalPosterUrl = movie["posters"]!["original"] as String
        originalPosterUrl = originalPosterUrl.stringByReplacingOccurrencesOfString("tmb", withString: "ori")
        mpaaRating = movie["mpaa_rating"] as String
        
        criticsScore = movie["ratings"]!["critics_score"] as Int
        audienceScore = movie["ratings"]!["audience_score"] as Int
        year = movie["year"] as Int
    }
    
    class func initWithMoviesArray(dictionaries: [NSDictionary]) -> [Movie] {
        var movies: [Movie] = [Movie]()
        for dictionary: NSDictionary in dictionaries {
            var movie: Movie = Movie()
            movie.initWithDictionary(dictionary)
            movies.append(movie)
        }
        return movies
    }
}
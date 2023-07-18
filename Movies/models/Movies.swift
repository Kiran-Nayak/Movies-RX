//
//  Movies.swift
//  Movie
//
//  Created by Kiran Nayak on 11/07/23.
//

import Foundation

/// It is a codable struct which is used to convet json into struct
struct Movies: Codable {
    let Title: String?
    let Year: String?
    let Rated: String?
    let Released: String?
    let Runtime: String?
    let Genre: String?
    let Director: String?
    let Writer: String?
    let Actors: String?
    let Plot: String?
    let Country: String?
    let Awards: String?
    let Poster: String?
    let Language: String?
    let Ratings: [Rating?]?
    let Metascore: String?
    let imdbRating: String?
    let imdbVotes: String?
    let imdbID: String?
    let `Type`: String?
    let DVD: String?
    let BoxOffice: String?
    let Production: String?
    let Website: String?
    let Response: String?
}

/// It is a codable struct which is used to convet json into struct
struct Rating: Codable {
    let Source: String?
    let Value: String?
}

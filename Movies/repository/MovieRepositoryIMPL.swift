//
//  MovieRepositoryIMPL.swift
//  Movies
//
//  Created by Kiran Nayak on 17/07/23.
//

import Foundation

/// It is implementation of MovieRepository
class MovieRepositoryIMPL: MovieRepository {
    func getMovieData<T: Codable>(type: T.Type) -> Result<T, Error> {
        return MovieServices().getMoviesData(responseType: type)
    }
}

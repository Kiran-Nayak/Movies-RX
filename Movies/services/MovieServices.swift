//
//  MovieServices.swift
//  Movies
//
//  Created by Kiran Nayak on 17/07/23.
//

import Foundation

/// This class is used to get data
class MovieServices {
    /// Used togetData
    /// - Parameters:
    ///   - type: Expected Response type
    public func getMoviesData<T: Codable>(
        responseType type: T.Type
    ) -> Result<T, Error> {
        guard let url = Bundle.main.url(forResource: "movies", withExtension: "json")
        else {
            print("Json file not found")
            return .failure(CustomError.unableToGetData)
        }
        
        do {
            let data = try Data(contentsOf: url)
            let users = try JSONDecoder().decode(T.self, from: data)
            return .success(users)
        } catch {
            return .failure(CustomError.unableToGetData)
        }
    }
}

/// Custom Errors
enum CustomError: Error {
    case unableToGetData
}

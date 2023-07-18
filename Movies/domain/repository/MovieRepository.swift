//
//  Repository.swift
//  Movies
//
//  Created by Kiran Nayak on 17/07/23.
//

import Foundation

/// This is a protocol which will impletemet in IMPL Class
/// This Protocol provides basic functions to communicate with viewmodel
protocol MovieRepository: AnyObject {
    func getMovieData<T: Codable>(type: T.Type) -> Result<T, Error>
}

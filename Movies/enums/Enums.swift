//
//  Enums.swift
//  Movie
//
//  Created by Kiran Nayak on 11/07/23.
//

import Foundation


/// This enum refers to the main category that is present in Movie application
enum MainCategory: String {
    case Year
    case Genre
    case Directors
    case Actors
    case None
    case Movie
}

/// This enum is used to specify cell of tableview
enum TableViewType {
    case titleList
    case posterList
}

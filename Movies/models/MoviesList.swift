//
//  MoviesList.swift
//  Movies
//
//  Created by Kiran Nayak on 17/07/23.
//

import Foundation


/// This is the struct responsible for showing tableview in Movie application
struct MoviesList {
    var type: TableViewType = .titleList
    var title: String?
    var movies: Movies?
    var category: MainCategory
    var filterBy: MainCategory
    init(type: TableViewType, title: String? = nil, movies: Movies? = nil, category: MainCategory, filterBy: MainCategory) {
        self.type = type
        self.title = title
        self.movies = movies
        self.category = category
        self.filterBy = filterBy
    }
}

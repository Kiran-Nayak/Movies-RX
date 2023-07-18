//
//  HomeViewModel.swift
//  Movies
//
//  Created by Kiran Nayak on 17/07/23.
//

import Foundation
import RxSwift
import RxCocoa

/// It is a viewmodel which contains all bussiness logic
class HomeViewModel {
    
    /// Creating instance of Repository as Viewmodel will create communication between View and Repository
    var movieRepository: MovieRepository
    
    /// Creating a publish subject which will return if there is any error and can be observable
    var moviesResponseError: PublishSubject<String> = PublishSubject()
    
    /// The list that will show in the main screen
    var moviesList: PublishSubject<[MoviesList]> = PublishSubject()
    
    /// Storing the response of movies
    private var movies: [Movies?] = []
    
    /// Initiallizer of ViewModel
    /// - Parameter movieRepository: Injecting MovieRepository instance at constructure level
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    /// Get the data from either server / local. and store the data in moviesResponse. By storing the value in moviesResponse, it can be observed
    func getMoviesData() {
        let result = movieRepository.getMovieData(type: [Movies].self)
        switch result {
        case .success(let data):
            movies = data
            getMoviesByCategory()
            break
        case .failure(let error):
            moviesResponseError.onNext(error.localizedDescription)
            break
        }
    }
    
    /// This function is used to get all categories such as Year, Genre, Directors, Actors
    func getMoviesByCategory() {
        var list: [MoviesList] = []
        list.append(MoviesList(type: .titleList, title: MainCategory.Year.rawValue, category: .Year, filterBy: .None))
        list.append(MoviesList(type: .titleList, title: MainCategory.Genre.rawValue, category: .Genre, filterBy: .None))
        list.append(MoviesList(type: .titleList, title: MainCategory.Directors.rawValue, category: .Directors, filterBy: .None))
        list.append(MoviesList(type: .titleList, title: MainCategory.Actors.rawValue, category: .Actors, filterBy: .None))
        moviesList.onNext(list)
    }
    
    
    /// This function helps to inflate appropriate data to the tableview
    /// - Parameters:
    ///   - type: Current type of category
    ///   - filter: Added any filter such as Year value, director name etc
    ///   - filterType: Describes whether filter is added for either year or Genre or Actor or Director
    func getSelectedCategoryItems(type: MainCategory, filter: String, filterType: MainCategory) {
        var list: [MoviesList] = []
        var set = Set<String>()
        var movies: [Movies] = []
        self.movies.forEach({ movie in
            switch type {
            case .Year:
                set.insert(movie?.Year ?? "")
            case .Genre:
                getSeparateData(str: movie?.Genre ?? "").forEach { data in
                    set.insert(data ?? "")
                }
            case .Directors:
                getSeparateData(str: movie?.Director ?? "").forEach { data in
                    set.insert(data ?? "")
                }
            case .Actors:
                getSeparateData(str: movie?.Actors ?? "").forEach { data in
                    set.insert(data ?? "")
                }
            case .None:
                break
            case .Movie:
                if getFilteredMovies(filterBy: filterType, filter: filter, movie: movie) {
                    if let movie = movie {
                        movies.append(movie)
                    }
                }
                break
            }
        })
        if type == .Movie {
            movies.forEach {
                list.append(MoviesList(type: .posterList, title: "NA", movies: $0, category: .Movie, filterBy: type))
            }
        }else {
            Array(set).forEach { item in
                list.append(MoviesList(type: .titleList, title: item, category: .Movie, filterBy: type))
            }
        }
        
        moviesList.onNext(list)
    }
    
    /// This function is used to separate the string and add it to a set to avoid duplicates
    /// - Parameter str: Input of String
    /// - Returns: Set of strings
    func getSeparateData(str: String) -> Set<String?> {
        let data = str.components(separatedBy: ", ")
        return Set(data)
    }
    
    /// This function is used to fliter the movies according to user preference
    /// - Parameters:
    ///   - filterBy: Describes whether filter is added for either year or Genre or Actor or Director
    ///   - filter: Added any filter such as Year value, director name etc
    ///   - movie: Movie object need to compare
    /// - Returns: Returns true if added filter matches with movie else false
    func getFilteredMovies(filterBy: MainCategory, filter: String, movie: Movies?) -> Bool {
        switch filterBy {
        case .Year:
            return (movie?.Year ?? "").contains(filter)
        case .Genre:
            return (movie?.Genre ?? "").contains(filter)
        case .Directors:
            return (movie?.Director ?? "").contains(filter)
        case .Actors:
            return (movie?.Actors ?? "").contains(filter)
        case .None:
            break
        case .Movie:
            break
        }
        return false
    }
    
    /// This function is used to give search movie name / title / Genre / Director
    /// - Parameter search: parameter that added by user using search field
    func getMoviesSearch(_ search: String) {
        var list: [MoviesList] = []
        if search.isEmpty {
            getMoviesByCategory()
            return
        }else {
            movies.forEach { movie in
                if (movie?.Title?.lowercased() ?? "").contains(search.lowercased()) || (movie?.Actors?.lowercased() ?? "").contains(search.lowercased()) || (movie?.Genre?.lowercased() ?? "").contains(search.lowercased()) || (movie?.Director?.lowercased() ?? "").contains(search.lowercased())  {
                    list.append(MoviesList(type: .posterList, title: "NA", movies: movie, category: .Movie, filterBy: .None))
                }
                
            }
        }
        moviesList.onNext(list)
    }
}

//
//  MovieListViewModel.swift
//  TestPepe
//
//  Created by José De Jesús Vega López on 04/11/24.
//

import Foundation

class MovieListViewModel {
    // MARK: - PRIVATE PROPERTIES
    private var model: MovieListModel
    private let repository: any MovieRepository
    
    // MARK: - INIT
    init() {
        self.model = MovieListModel()
        self.repository = MovieListRepository()
    }
    
    // MARK: - PUBLIC PROPERTIES
    var router: MovieListRouter!
    
    var totalPages: Int {
        get {
            self.model.totalPages
        }
        set {
            self.model.totalPages = newValue
        }
    }
    
    var page: Int {
        get {
            self.model.page
        }
        set {
            self.model.page = newValue
        }
    }
    
    var language: String {
        self.model.language
    }
    
    var movieList: [MovieListResponse.MovieList] {
        get {
            self.model.movieList
        }
        set {
            self.model.movieList = newValue
        }
    }
    
    var stateView: StateView {
        self.movieList.isEmpty ? .empty : .hasContent
    }
    
    var movieListRequest: MovieListRequest {
        get {
            self.model.movieListRequest
        }
        set {
            self.model.movieListRequest = newValue
        }
    }
    
    var hasMoreItems: Bool {
        self.page < self.totalPages
    }
    
    func getMovieList(resetModel: Bool = false) async throws {
        // Uncomment this to see empty state
        /*
        self.page = 1
        self.movieList = []
        return
         */
        // Uncomment this to see a Networking error
        /*
        throw NetworkingError.customError(msg: "Custom error message")
         */
        let request = MovieListRequest(
            language: self.language,
            page: resetModel ? 1 : self.page + 1
        )
        let response = try await self.repository.getMovieList(request)
        guard let page = response.page, let movieList = response.results, let totalPages = response.totalPages else {
            throw NetworkingError.generalError
        }
        self.totalPages = totalPages
        if resetModel {
            self.page = 1
            self.movieList = movieList
        }
        else {
            self.page = page
            self.movieList = self.movieList + movieList
        }
    }
    
    func routeToMovieDetail(index: Int) {
        let data = self.movieList[index]
        self.router.routeToMovieDetail(with: data)
    }
}

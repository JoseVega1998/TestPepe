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
    
    // MARK: - INIT
    init() {
        self.model = MovieListModel()
    }
    
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
        let queryItems = MovieListRequest(
            language: self.language,
            page: self.page
        ).dictionary
        let request = ApiRequestModel(
            endpoint: .topRated,
            method: .get,
            header: .Authorization,
            encoding: .url,
            parameters: queryItems
        )
        let response = try await ApiService.shared.request(
            request,
            MovieListResponse.self
        )
        guard let page = response.page, let movieList = response.results, let totalPages = response.totalPages else {
            throw NetworkingError.generalError
        }
        self.totalPages = totalPages
        if resetModel {
            self.page = 1
            self.movieList = movieList
        }
        else {
            self.page = page + 1
            self.movieList = self.movieList + movieList
        }
    }
}

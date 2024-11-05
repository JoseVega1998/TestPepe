//
//  MovieListModel.swift
//  TestPepe
//
//  Created by José De Jesús Vega López on 04/11/24.
//

import Foundation

struct MovieListModel {
    var page: Int = 1
    var totalPages: Int = 0
    var language: String = "en-US"
    var movieList: [MovieListResponse.MovieList] = []
    var movieListRequest: MovieListRequest = MovieListRequest()
}

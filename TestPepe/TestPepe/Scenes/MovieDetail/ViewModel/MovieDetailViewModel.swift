//
//  MovieDetailViewModel.swift
//  TestPepe
//
//  Created by José De Jesús Vega López on 04/11/24.
//

import Foundation

class MovieDetailViewModel {
    // MARK: - PRIVATE PROPERTIES
    private var model: MovieDetailModel
    
    // MARK: - INIT
    init(movie: MovieListResponse.MovieList) {
        self.model = MovieDetailModel(movie: movie)
    }
    
    var movie: MovieListResponse.MovieList {
        self.model.movie
    }
    
    var movieTitle: String {
        self.movie.title ?? ""
    }
    
    var movieAvatar: String {
        "\((self.movie.title ?? "").prefix(2))"
    }
    
    var movieReleaseDate: String {
        self.movie.releaseDate ?? ""
    }
    
    var movieVoteAverage: String {
        "\((self.movie.voteAverage ?? 0.0).rounded(toPlaces: 1))"
    }
    
    var movieBackdrop: String {
        self.movie.backdropPath ?? ""
    }
    
    var movieBanner: String {
        self.movie.posterPath ?? ""
    }
    
    var recommended: Bool {
        (self.movie.voteAverage ?? 0.0) > 5
    }
    
    var recommendedDescription: String {
        self.recommended ? "Recommended" : "Not recommended"
    }
    
    var description: String {
        self.movie.overview ?? ""
    }
}

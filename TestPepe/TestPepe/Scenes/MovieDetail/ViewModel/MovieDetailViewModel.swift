//
//  MovieDetailViewModel.swift
//  TestPepe
//
//  Created by José De Jesús Vega López on 04/11/24.
//

import Foundation

class MovieDetailViewModel {
    // MARK: - PRIVATE PROPERTIES
    private var model = MovieDetailModel()
        
    // MARK: - PUBLIC PROPERTIES
    var router: MovieDetailRouter!
    var _movie: MovieListResponse.MovieList?
        
    var movie: MovieListResponse.MovieList {
        self._movie!
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

    var voteAverage: String {
        "\((self.movie.voteAverage ?? 0.0).rounded(toPlaces: 1))/10"
    }
    
    var adultsOnly: (ban: Bool, title: String) {
        if (self.movie.adult ?? false) {
            return (true, "Adults only!")
        }
        else {
            return (false, "Family friendly")
        }
    }
    
    var isPopular: (ban: Bool, title: String) {
        if (self.movie.popularity ?? 0.0) > 120 {
            return (true, "It's popular!")
        }
        else {
            return (false, "It's not popular")
        }
    }
    
    var hasTrailer: Bool {
        self.movie.video ?? false
    }
    
    var trailerAlert: (title: String, body: String) {
        return (
            "Opps",
            self.hasTrailer ? "The video player could not be started, please try again later." : "The trailer has not available, please try with another movie."
        )
    }
}

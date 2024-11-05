//
//  MovieListResponse.swift
//  TestPepe
//
//  Created by José De Jesús Vega López on 04/11/24.
//

import Foundation

struct MovieListResponse: Codable {
    var page: Int?
    var results: [MovieList]?
    var totalPages: Int?
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
    }
    
    struct MovieList: Codable {
        var adult: Bool?
        var backdropPath: String?
        var originalLanguage, originalTitle, overview: String?
        var popularity: Double?
        var posterPath, releaseDate, title: String?
        var video: Bool?
        var voteAverage: Double?
        var voteCount: Int?

        enum CodingKeys: String, CodingKey {
            case adult
            case backdropPath = "backdrop_path"
            case originalLanguage = "original_language"
            case originalTitle = "original_title"
            case overview, popularity
            case posterPath = "poster_path"
            case releaseDate = "release_date"
            case title, video
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
        }

    }
}

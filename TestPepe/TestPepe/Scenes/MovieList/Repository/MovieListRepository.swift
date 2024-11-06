//
//  MovieListRepository.swift
//  TestPepe
//
//  Created by José De Jesús Vega López on 05/11/24.
//

import Foundation

protocol MovieRepository {
    func getMovieList(_ request: MovieListRequest) async throws -> MovieListResponse
}

actor MovieListRepository: MovieRepository {
    func getMovieList(_ request: MovieListRequest) async throws -> MovieListResponse {
        let queryItems = request.dictionary
        let request = ApiRequestModel(
            endpoint: .topRated,
            method: .get,
            header: .Authorization,
            encoding: .url,
            parameters: queryItems
        )
        return try await ApiService.shared.request(
            request,
            MovieListResponse.self
        )
    }
    
}


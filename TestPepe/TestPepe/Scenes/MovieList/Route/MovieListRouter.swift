//
//  MovieListRouter.swift
//  TestPepe
//
//  Created by José De Jesús Vega López on 05/11/24.
//

import UIKit

protocol MovieListRouterProtocol {
    func routeToMovieDetail(with movie: MovieListResponse.MovieList)
}

class MovieListRouter: MovieListRouterProtocol {
    var viewController: UIViewController?
    
    func routeToMovieDetail(with movie: MovieListResponse.MovieList) {
        let viewController = MovieDetailModule().build()
        viewController.viewModel._movie = movie
        Navigation.navigate(to: viewController, from: self.viewController, using: .push)
    }

}

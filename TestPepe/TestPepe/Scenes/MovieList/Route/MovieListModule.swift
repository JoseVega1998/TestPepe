//
//  MovieListModule.swift
//  TestPepe
//
//  Created by José De Jesús Vega López on 05/11/24.
//

import UIKit

class MovieListModule {
    func build() -> MovieListViewController {
        let storyboard = UIStoryboard(name: ViewControllers.MovieListView.rawValue, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: ViewControllers.MovieListView.rawValue) as! MovieListViewController
        viewController.viewModel.router = MovieListRouter()
        viewController.viewModel.router?.viewController = viewController
        return viewController
    }
}

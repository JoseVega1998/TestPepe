//
//  MovieDetailModule.swift
//  TestPepe
//
//  Created by José De Jesús Vega López on 05/11/24.
//

import UIKit

class MovieDetailModule {
    func build() -> MovieDetailViewController {
        let storyboard = UIStoryboard(name: ViewControllers.MovieDetailView.rawValue, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: ViewControllers.MovieDetailView.rawValue) as! MovieDetailViewController
        viewController.viewModel.router = MovieDetailRouter()
        viewController.viewModel.router?.viewController = viewController
        return viewController
    }
}

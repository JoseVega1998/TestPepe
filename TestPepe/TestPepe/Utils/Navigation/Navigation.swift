//
//  Navigation.swift
//  TestPepe
//
//  Created by José De Jesús Vega López on 04/11/24.
//

import UIKit

struct Navigation {
    
    static func createMovieListVc() -> MovieListViewController {
        UIStoryboard(
            name: ViewControllers.MovieListView.rawValue,
            bundle: nil
        ).instantiateViewController(
            identifier: ViewControllers.MovieListView.rawValue
        ) { coder in
            MovieListViewController(coder: coder)
        }
    }
    
    static func createMovieDetailVc(movie: MovieListResponse.MovieList) -> MovieDetailViewController {
        UIStoryboard(
            name: ViewControllers.MovieDetailView.rawValue,
            bundle: nil
        ).instantiateViewController(
            identifier: ViewControllers.MovieDetailView.rawValue
        ) { coder in
            MovieDetailViewController(coder: coder, movie: movie)
        }
    }
    
    static func navigate(
        to destination: UIViewController,
        from source: UIViewController,
        using: NavigationStyle,
        animated: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        switch using {
        case .present:
            source.present(destination, animated: animated, completion: completion)
        case .push:
            guard let nv = source.navigationController else {
                print("source has not embed in navigation controller")
                return
            }
            nv.pushViewController(destination, animated: animated)
        case .presentBottomSheet:
            destination.isModalInPresentation = true
            if let sheet = destination.sheetPresentationController {
                sheet.detents = [.medium()]
                sheet.selectedDetentIdentifier = .medium
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
                sheet.prefersEdgeAttachedInCompactHeight = true
            }
            source.present(destination, animated: true, completion: completion)
        }
    }
}

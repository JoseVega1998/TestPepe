//
//  SplashRouter.swift
//  TestPepe
//
//  Created by José De Jesús Vega López on 05/11/24.
//

import UIKit

protocol SplashRouterProtocol {
    func routeToMovieList()
}

class SplashRouter: SplashRouterProtocol {
    var viewController: UIViewController?
    
    func routeToMovieList() {
        let viewController = MovieListModule().build()
        Navigation.navigate(to: viewController, from: self.viewController, using: .push)
    }
}

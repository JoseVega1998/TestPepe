//
//  SplashModule.swift
//  TestPepe
//
//  Created by José De Jesús Vega López on 05/11/24.
//

import UIKit

class SplashModule {
    func build() -> SplashViewController {
        let storyboard = UIStoryboard(name: ViewControllers.SplashView.rawValue, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: ViewControllers.SplashView.rawValue) as! SplashViewController
        viewController.viewModel.router = SplashRouter()
        viewController.viewModel.router?.viewController = viewController
        return viewController
    }
}

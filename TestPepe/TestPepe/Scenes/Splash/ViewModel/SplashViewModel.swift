//
//  SplashViewModel.swift
//  TestPepe
//
//  Created by José De Jesús Vega López on 05/11/24.
//

import Foundation

class SplashViewModel {
    // MARK: - PRIVATE PROPERTIES
    private var model: SplashModel
    
    // MARK: - INIT
    init() {
        self.model = SplashModel()
    }
    
    // MARK: - PUBLIC PROPERTIES
    var router: SplashRouter!
    
    var seconds: Double {
        self.model.seconds
    }
    
    func navigateToMovieList() {
        self.router.routeToMovieList()
    }
}

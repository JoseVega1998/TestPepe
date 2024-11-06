//
//  SplashViewController.swift
//  TestPepe
//
//  Created by José De Jesús Vega López on 05/11/24.
//

import UIKit

class SplashViewController: BaseViewController {
    
    var viewModel = SplashViewModel()
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.startLoader()
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func startLoader() {
        super.showLoader(with: "Starting application...\n Vega Lópes José de Jesús")
        DispatchQueue.main.asyncAfter(deadline: .now() + self.viewModel.seconds) {
            super.dismissLoader()
            self.viewModel.navigateToMovieList()
        }
    }
}

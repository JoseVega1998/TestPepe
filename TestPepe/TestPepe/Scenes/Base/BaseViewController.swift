//
//  BaseViewController.swift
//  TestPepe
//
//  Created by José De Jesús Vega López on 04/11/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    private let loaderView = Loader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .background2
        self.configureNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
        
    private func configureNavigationBar() {
        guard let nv = self.navigationController else { return }
        nv.navigationBar.prefersLargeTitles = false
        nv.navigationBar.isTranslucent = true
        let backImage = UIImage(systemName: "chevron.left.circle.fill")?.withTintColor(.primary)
        nv.navigationBar.backIndicatorImage = backImage
        nv.navigationBar.backIndicatorTransitionMaskImage = backImage
        nv.navigationBar.backItem?.title = ""
        nv.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.primary,
            .font: UIFont.titleFont(type: .Black)
        ]
    }
    
    func showLoader() {
        self.view.addSubview(self.loaderView)
    }
    
    func dismissLoader() {
        self.loaderView.removeFromSuperview()
    }

}

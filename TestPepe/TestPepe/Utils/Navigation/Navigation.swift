//
//  Navigation.swift
//  TestPepe
//
//  Created by José De Jesús Vega López on 04/11/24.
//

import UIKit

struct Navigation {
    // MARK: - NAVIGATION
    public static func navigate(
        to destination: UIViewController,
        from source: UIViewController?,
        using: NavigationStyle,
        animated: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        switch using {
        case .present:
            source?.present(destination, animated: animated, completion: completion)
        case .push:
            guard let nv = source?.navigationController else {
                fatalError("source has not embed in navigation controller")
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
            source?.present(destination, animated: animated, completion: completion)
        }
    }
}

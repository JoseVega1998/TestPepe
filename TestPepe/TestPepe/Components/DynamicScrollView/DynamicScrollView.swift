//
//  DynamicScrollView.swift
//  TestPepe
//
//  Created by José De Jesús Vega López on 04/11/24.
//

import UIKit

class DynamicHeightScrollView: UIScrollView {
    
    // MARK: - PRIVATE PROPERTIES
    private var contentView: UIView
    
    // MARK: - INIT
    init(contentView: UIView) {
        self.contentView = contentView
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func setUpUI() {
        self.addSubview(contentView)
        self.contentView.setConstraints(
            top: self.contentLayoutGuide.topAnchor,
            bottom: self.contentLayoutGuide.bottomAnchor,
            left: self.leftAnchor,
            right: self.rightAnchor
        )
    }
}

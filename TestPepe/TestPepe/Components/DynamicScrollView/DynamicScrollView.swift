//
//  DynamicScrollView.swift
//  TestPepe
//
//  Created by José De Jesús Vega López on 04/11/24.
//

import UIKit

class DynamicHeightScrollView: UIScrollView {
    
    var contentView: UIView
    
    init(contentView: UIView) {
        self.contentView = contentView
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI() {
        self.addSubview(contentView)
        self.contentView.setConstraints(
            top: self.contentLayoutGuide.topAnchor,
            bottom: self.contentLayoutGuide.bottomAnchor,
            left: self.leftAnchor,
            right: self.rightAnchor
        )
    }
}

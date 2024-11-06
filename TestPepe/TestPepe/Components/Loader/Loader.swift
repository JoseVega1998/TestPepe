//
//  Loader.swift
//  TestPepe
//
//  Created by José De Jesús Vega López on 04/11/24.
//

import UIKit

class Loader: UIView {
    
    // MARK: - COMPONENTS
    private let label: UILabel = {
        let label = UILabel()
        label.font = .bodyLFont(type: .Bold)
        label.textColor = .primary
        label.numberOfLines = LoaderConstants.ViewModifiers.maxLinesNumber
        label.text = "Wait a minute"
        label.textAlignment = .center
        return label
    }()
    
    private let indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.setSquareView(with: 50)
        view.color = .primary
        view.startAnimating()
        return view
    }()
    
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            self.indicatorView,
            self.label
        ])
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fill
        stack.alignment = .center
        return stack
    }()
    
    // MARK: - INIT
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init() has not been implemented")
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func setUpUI() {
        self.setHeight(height: UIScreen.screenHeight)
        self.setWidth(width: UIScreen.screenWidth)
        self.backgroundColor = .background2.withAlphaComponent(0.8)
        self.addSubview(self.contentStack)
        self.contentStack.centerInView(with: self)
    }
    
    // MARK: - PUBLIC FUNCTIONS
    func setText(with text: String) {
        self.label.text = text
    }
    
}

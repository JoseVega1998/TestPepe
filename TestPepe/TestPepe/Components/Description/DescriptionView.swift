//
//  DescriptionView.swift
//  TestPepe
//
//  Created by José De Jesús Vega López on 04/11/24.
//

import UIKit

@objc public class DescriptionView: UIView {
        
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyFont(type: .Bold)
        label.textColor = .secondaryLight
        label.numberOfLines = DescriptionConstants.ViewModifiers.maxTitleLinesNumber
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyFont(type: .Regular)
        label.textColor = .primary
        label.numberOfLines = DescriptionConstants.ViewModifiers.maxDescriptionLinesNumber
        return label
    }()
    
    private lazy var contentStack: UIStackView = {
        let verticalStack = UIStackView(arrangedSubviews: [
            self.titleLabel,
            self.descriptionLabel
        ])
        verticalStack.axis = .vertical
        verticalStack.spacing = 4
        verticalStack.distribution = .fill
        verticalStack.alignment = .leading
        
        return verticalStack
    }()
            
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init() has not been implemented")
    }
    
    private func setUpUI() {
        self.backgroundColor = .clear
        self.addSubview(self.contentStack)
        self.contentStack.setConstraints(
            top: self.topAnchor,
            bottom: self.bottomAnchor,
            left: self.leftAnchor,
            paddingLeft: 16,
            right: self.rightAnchor,
            paddingRight: 16
        )
    }
    
    public func configure(title: String, description: String) {
        self.titleLabel.text = title
        self.descriptionLabel.text = description
    }
        
}

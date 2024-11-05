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
    
    private let textButton: CustomButton = {
        let button = CustomButton()
        return button
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
        
        let horizontalStack = UIStackView(arrangedSubviews: [
            verticalStack,
            self.textButton
        ])
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = 4
        horizontalStack.distribution = .fill
        horizontalStack.alignment = .bottom
        
        return horizontalStack
    }()
    
    private var titleText: String = ""
    private var bodyText: String = ""
    private var buttonTitle: String = ""
    private var buttonAction:(() -> Void)?

    var hasButton: Bool {
        return self.buttonAction != nil && !self.titleText.isEmpty
    }
                
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init() has not been implemented")
    }
    
    func configure(
        title: String,
        description: String,
        buttonTitle: String,
        buttonAction: @escaping (() -> Void)
    ) {
        self.titleText = title
        self.bodyText = description
        self.buttonTitle = buttonTitle
        self.buttonAction = buttonAction
        self.configureComponents()
    }
    
    func configure(title: String, description: String) {
        self.titleText = title
        self.bodyText = description
        self.configureComponents()
    }

    private func configureComponents() {
        self.titleLabel.text = self.titleText
        self.descriptionLabel.text = self.bodyText
        if let action = self.buttonAction {
            self.textButton.setUp(type: .Text, title: self.buttonTitle)
            self.textButton.setAction { action() }
        }
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
        //self.textButton.isHidden = !self.hasButton
    }
        
}

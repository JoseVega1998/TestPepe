//
//  DescriptionView.swift
//  TestPepe
//
//  Created by José De Jesús Vega López on 04/11/24.
//

import UIKit

class DescriptionView: UIView {
        
    // MARK: - PRIVATE PROPERTIES
    private var titleText: String = ""
    private var bodyText: String = ""
    private var buttonTitle: String = ""
    private var buttonAction:(() -> Void)?

    private var hasButton: Bool {
        return !self.titleText.isEmpty
    }
    
    // MARK: - COMPONENTS
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

    private func configureComponents() {
        self.titleLabel.text = self.titleText
        self.descriptionLabel.text = self.bodyText
        self.textButton.setUp(type: .Text, title: self.buttonTitle)
        if let action = self.buttonAction {
            self.textButton.setAction { action() }
        }
    }
        
    // MARK: - PUBLIC FUNCTIONS
    public func configure(
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
        
}

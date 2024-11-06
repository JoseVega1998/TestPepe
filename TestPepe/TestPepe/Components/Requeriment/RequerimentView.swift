//
//  RequerimentView.swift
//  TestPepe
//
//  Created by José De Jesús Vega López on 04/11/24.
//

import UIKit

@objc public class RequerimentView: UIView {
        
    // MARK: - COMPONENTS
    private let icon: UIImageView = {
        let image = UIImage.checkmark.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: image)
        imageView.tintColor = UIColor.primary
        imageView.isHidden = true
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyFont(type: .Medium)
        label.textColor = .primary
        label.numberOfLines = RequerimentConstants.ViewModifiers.maxLinesNumber
        return label
    }()
        
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            self.icon,
            self.descriptionLabel
        ])
        stack.spacing = 8
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
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
        self.backgroundColor = .alertLight
        self.layer.cornerRadius = RequerimentConstants.ViewModifiers.cornerRadius
        self.addSubview(self.contentStack)
        self.contentStack.setConstraints(
            top: self.topAnchor,
            paddingTop: 8,
            bottom: self.bottomAnchor,
            paddingBottom: 8,
            left: self.leftAnchor,
            paddingLeft: 8,
            right: self.rightAnchor,
            paddingRight: 8
        )
    }
    
    // MARK: - PUBLIC FUNCTIONS
    public func setDescription(with description: String) {
        self.descriptionLabel.text = description
    }
    
    public func isCheck(with check: Bool) {
        UIView.animate(withDuration: 0.5) {
            self.icon.isHidden = !check
        }
    }
    
    public func setHasAlert(with description: String) {
        self.descriptionLabel.text = description
        self.descriptionLabel.textColor = .systemRed
        self.backgroundColor = .systemRed.withAlphaComponent(0.1)
        self.icon.image = UIImage(systemName: "xmark.circle.fill") ?? .add
        self.icon.isHidden = false
        self.icon.tintColor = .systemRed
    }
}

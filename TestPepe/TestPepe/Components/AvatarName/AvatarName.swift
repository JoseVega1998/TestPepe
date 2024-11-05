//
//  AvatarName.swift
//  TestPepe
//
//  Created by José De Jesús Vega López on 04/11/24.
//

import UIKit

@objc public class AvatarName: UIView {
        
    private lazy var avatarView: AvatarView = {
        let view = AvatarView(frame: .zero)
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyFont(type: .Medium)
        label.textColor = .primary
        label.numberOfLines = AvatarNameConstants.ViewModifiers.maxLinesNumber
        return label
    }()
    
    private let productLabel: UILabel = {
        let label = UILabel()
        label.font = .bodySFont(type: .Regular)
        label.textColor = .lightGray
        label.numberOfLines = AvatarNameConstants.ViewModifiers.maxLinesNumber
        return label
    }()
    
    private lazy var contentStack: UIStackView = {
        let verticalStack = UIStackView(arrangedSubviews: [
            self.nameLabel,
            self.productLabel
        ])
        verticalStack.axis = .vertical
        verticalStack.distribution = .fillProportionally
        verticalStack.alignment = .leading
        self.nameLabel.setConstraints(
            left: verticalStack.leftAnchor,
            right: verticalStack.rightAnchor,
            paddingRight: 16
        )
        self.productLabel.setConstraints(
            left: verticalStack.leftAnchor,
            right: verticalStack.rightAnchor,
            paddingRight: 16
        )
        let horizontalStack = UIStackView(arrangedSubviews: [
            self.avatarView,
            verticalStack
        ])
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = 8
        horizontalStack.distribution = .fillProportionally
        horizontalStack.alignment = .center
        return horizontalStack
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
            right: self.rightAnchor
        )
    }
    
    public func setUp(avatar: String, name: String, product: String) {
        self.avatarView.setAvatar(with: avatar)
        self.nameLabel.text = name
        self.productLabel.text = product
    }
        
}

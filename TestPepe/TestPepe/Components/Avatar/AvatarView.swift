//
//  AvatarView.swift
//  TestPepe
//
//  Created by José De Jesús Vega López on 02/11/24.
//

import UIKit

@objc public class AvatarView: UIView {
        
    private let label: UILabel = {
        let label = UILabel()
        label.font = .bodyLFont(type: .Bold)
        label.textColor = .primary
        label.numberOfLines = AvatarConstants.ViewModifiers.maxLinesNumber
        return label
    }()
            
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init() has not been implemented")
    }
    
    private func setUpUI() {
        self.setSquareView(with: AvatarConstants.ViewModifiers.height)
        self.layer.cornerRadius = AvatarConstants.ViewModifiers.height / 2
        self.clipsToBounds = true
        self.backgroundColor = .third
        self.addSubview(self.label)
        self.label.centerInView(with: self)
    }
    
    public func setAvatar(with text: String) {
        self.label.text = text
    }
        
}

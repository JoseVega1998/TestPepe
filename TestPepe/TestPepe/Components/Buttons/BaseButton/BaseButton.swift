//
//  BaseButton.swift
//  TestPepe
//
//  Created by José De Jesús Vega López on 02/11/24.
//

import UIKit

@objc public class BaseButton: UIButton {
    var buttonModel: ButtonModel?
    
    public override var intrinsicContentSize: CGSize {
        CGSize(
            width: (titleLabel?.intrinsicContentSize.width ?? 0.0) + ButtonsConstants.ViewModifiers.contentInsetLateral,
            height: ButtonsConstants.ViewModifiers.height
        )
    }
    
    override open var isEnabled: Bool {
        didSet {
            if let buttonModel = self.buttonModel {
                self.backgroundColor = isEnabled ? buttonModel.colorSet.backgroundColor : buttonModel.colorSet.disableBackgroundColor
                self.setUpTitle()
                if buttonModel.withBorder {
                    self.layer.borderColor = isEnabled ? buttonModel.colorSet.foregroundColor.cgColor : buttonModel.colorSet.disableForegroundColor.cgColor
                }
            }
        }
    }
    
    override open var isHighlighted: Bool {
        didSet {
            if let buttonModel = self.buttonModel {
                self.backgroundColor = isEnabled ? buttonModel.colorSet.backgroundColor : buttonModel.colorSet.highlightedBackGroundColor
                self.setUpTitle()
                if buttonModel.withBorder {
                    self.layer.borderColor = isEnabled ? buttonModel.colorSet.foregroundColor.cgColor : buttonModel.colorSet.highlightedForegroundColor.cgColor
                }
            }
        }
    }
        
    private func setUpAppareance() {
        guard let buttonModel = self.buttonModel else { return }
        self.backgroundColor = buttonModel.colorSet.backgroundColor
        self.titleLabel?.numberOfLines = ButtonsConstants.ViewModifiers.maxLinesNumber
        self.layer.cornerRadius = buttonModel.cornerRadius
        self.setHeight(height: ButtonsConstants.ViewModifiers.height)
        if buttonModel.withBorder {
            self.layer.borderColor = buttonModel.colorSet.foregroundColor.cgColor
            self.layer.borderWidth = ButtonsConstants.ViewModifiers.borderWidth
        }
    }
    
    private func setUpTitle() {
        guard let buttonModel = self.buttonModel else { return }
        [.normal, .highlighted, .disabled].forEach { state in
            self.setAttributedTitle(
                self.makeTitke(
                    title: buttonModel.title,
                    state: state
                ),
                for: state
            )
        }
    }
    
    private func makeTitke(title: String, state: UIControl.State) -> NSAttributedString {
        guard let buttonModel = self.buttonModel else { return NSAttributedString() }
        let color: UIColor = {
            switch state {
            case .normal: return buttonModel.colorSet.foregroundColor
            case .highlighted: return buttonModel.colorSet.highlightedForegroundColor
            case .disabled: return buttonModel.colorSet.disableForegroundColor
            default: return buttonModel.colorSet.foregroundColor
            }
        }()
        return NSMutableAttributedString(
            string: buttonModel.title,
            attributes: [
                .font: buttonModel.baseFont,
                .foregroundColor: color,
                .underlineStyle: buttonModel.withUnderline ? NSUnderlineStyle.single.rawValue : "",
                .underlineColor: buttonModel.withUnderline ? color : .clear
            ]
        )
    }
    
    public func setUpUI(model: ButtonModel) {
        self.buttonModel = model
        self.setUpAppareance()
        self.setUpTitle()
    }
    
    public func setIcon(with icon: UIImage) {
        guard let buttonModel = self.buttonModel else { return }
        let tintedIcon = icon.withRenderingMode(.alwaysTemplate)
        self.setImage(tintedIcon, for: .normal)
        self.tintColor = buttonModel.colorSet.foregroundColor
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)

    }
}

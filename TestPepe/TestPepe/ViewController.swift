//
//  ViewController.swift
//  TestPepe
//
//  Created by José De Jesús Vega López on 01/11/24.
//

import UIKit

class ViewController: UIViewController {

    private lazy var primaryIconButton: CustomButton = {
        let button = CustomButton()
        button.setUp(type: .Primary, title: "PRIMARY WITH ICON")
        button.setIcon(with: .init(named: "pencil") ?? .add)
        button.setAction {
            print("ACTION")
        }
        return button
    }()

    private lazy var primaryButton: CustomButton = {
        let button = CustomButton()
        button.setUp(type: .Primary, title: "PRIMARY")
        button.setAction {
            print("ACTION")
        }
        return button
    }()

    private lazy var secondaryIconButton: CustomButton = {
        let button = CustomButton()
        button.setUp(type: .Secondary, title: "SECONDARY WITH ICON")
        button.setIcon(with: .checkmark)
        button.setAction {
            print("ACTION")
        }
        return button
    }()

    private lazy var secondaryButton: CustomButton = {
        let button = CustomButton()
        button.setUp(type: .Secondary, title: "SECONDARY")
        button.setAction {
            print("ACTION")
        }
        return button
    }()

    private lazy var textIconButton: CustomButton = {
        let button = CustomButton()
        button.setUp(type: .Text, title: "TEXT WITH ICON")
        button.setIcon(with: .checkmark)
        button.setAction {
            print("ACTION")
        }
        return button
    }()

    private lazy var textButton: CustomButton = {
        let button = CustomButton()
        button.setUp(type: .Text, title: "TEXT")
        button.setAction {
            print("ACTION")
        }
        return button
    }()
    
    private lazy var avatarView: AvatarView = {
        let view = AvatarView(frame: .zero)
        view.setAvatar(with: "VL")
        return view
    }()
    
    private lazy var testButtons: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: [
                primaryIconButton,
                primaryButton,
                secondaryIconButton,
                secondaryButton,
                textIconButton,
                textButton,
                avatarView
            ]
        )
        stack.axis = .vertical
        stack.spacing = 12
        stack.distribution = .fillProportionally
        stack.alignment = .center
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.testButtons)
        self.testButtons.setConstraints(
            top: self.view.safeAreaLayoutGuide.topAnchor,
            left: self.view.leftAnchor,
            right: self.view.rightAnchor
        )
    }


}


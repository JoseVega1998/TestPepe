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
        button.setUp(type: .Primary, title: "INIT APLICATION")
        button.setIcon(with: .init(named: "pencil") ?? .add)
        button.setAction {
            self.initApp()
        }
        return button
    }()
    
    private lazy var primaryButton: CustomButton = {
        let button = CustomButton()
        button.setUp(type: .Primary, title: "INCOMPLETE REQUERIMENT")
        button.setAction {
            self.requerimentView.isCheck(with: false)
        }
        return button
    }()
    
    private lazy var secondaryIconButton: CustomButton = {
        let button = CustomButton()
        button.setUp(type: .Secondary, title: "COMPLETE REQUERIMENT")
        button.setIcon(with: .checkmark)
        button.setAction {
            self.requerimentView.isCheck(with: true)
        }
        return button
    }()
    
    private lazy var secondaryButton: CustomButton = {
        let button = CustomButton()
        button.setUp(type: .Secondary, title: "PRESENT COMPLETE ALERT")
        button.setAction {
            self.textCompleteBottomSheet()
        }
        return button
    }()
    
    private lazy var textIconButton: CustomButton = {
        let button = CustomButton()
        button.setUp(type: .Text, title: "PRESENT ALERT WITH SECONDARY BUTTON")
        button.setIcon(with: .checkmark)
        button.setAction {
            self.testBottomSheetSecondaryButton()
        }
        return button
    }()
    
    private lazy var textButton: CustomButton = {
        let button = CustomButton()
        button.setUp(type: .Text, title: "PRESENT SIMPLE ALERT")
        button.setAction {
            self.testBottomSheet()
        }
        return button
    }()
    
    private lazy var avatarView: AvatarView = {
        let view = AvatarView(frame: .zero)
        view.setAvatar(with: "VL")
        return view
    }()
    
    private lazy var avatarNameView: AvatarName = {
        let view = AvatarName()
        view.setUp(avatar: "VL", name: "Vega López José de Jesús", product: "Stori producto")
        return view
    }()
    
    private lazy var requerimentView: RequerimentView = {
        let view = RequerimentView()
        view.setDescription(with: "Mínimo 8 caracteres")
        return view
    }()
    
    private lazy var testContent: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: [
                primaryIconButton,
                primaryButton,
                secondaryIconButton,
                secondaryButton,
                textIconButton,
                textButton,
                avatarView,
                avatarNameView,
                requerimentView
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
        self.view.addSubview(self.testContent)
        self.testContent.setConstraints(
            top: self.view.safeAreaLayoutGuide.topAnchor,
            left: self.view.leftAnchor,
            right: self.view.rightAnchor
        )
    }
    
    private func testBottomSheet() {
        let alertView = AlertView(
            image: .alert,
            title: "TITLE",
            body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat",
            primaryButtonText: "PRIMARY BUTTON",
            primaryPerforms: {
                self.dismiss(animated: true) {
                    print("ACTION")
                }
            },
            additionalCloseAction: {
                print("CLOSE")
            }
        )
        Navigation.navigate(to: alertView, from: self, using: .presentBottomSheet)
    }
    
    private func testBottomSheetSecondaryButton() {
        let alertView = AlertView(
            image: .alert,
            title: "TITLE",
            body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat",
            secondaryButtonText: "SECONDARY BUTTON",
            secondaryPerforms: {
                self.dismiss(animated: true) {
                    print("ACTION")
                }
            },
            additionalCloseAction: {
                print("CLOSE")
            }
        )
        Navigation.navigate(to: alertView, from: self, using: .presentBottomSheet)
    }
    
    private func textCompleteBottomSheet() {
        let alertView = AlertView(
            image: .alert,
            title: "TITLE",
            body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat",
            primaryButtonText: "PRIMARY BUTTON",
            primaryPerforms:  {
                self.dismiss(animated: true) {
                    print("ACTION")
                }
            },
            secondaryButtonText: "SECONDARY BUTTON",
            secondaryPerforms: {
                self.dismiss(animated: true) {
                    print("ACTION")
                }
            }
        )
        Navigation.navigate(to: alertView, from: self, using: .presentBottomSheet)
    }
    
    private func initApp() {
        Navigation.navigate(
            to: Navigation.createMovieListVc(),
            from: self,
            using: .push
        )
    }
}


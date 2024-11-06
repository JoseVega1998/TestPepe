//
//  AlertView.swift
//  TestPepe
//
//  Created by José De Jesús Vega López on 04/11/24.
//

import UIKit

class AlertView: UIViewController {
    
    // MARK: - PRIVATE PROPERTIES
    private var image: UIImage = UIImage.alert
    private var titleText: String = ""
    private var bodyText: String = ""
    private var primaryButtonText: String = ""
    private var secondaryButtonText: String = ""
    private var primaryPerforms:(() -> Void)?
    private var secondaryPerforms:(() -> Void)?
    private var additionalCloseAction:(() -> Void)?
    
    private var hasPrimaryButton: Bool {
        return self.primaryPerforms != nil && !self.primaryButtonText.isEmpty
    }
    
    private var hasSecondaryButton: Bool {
        return self.secondaryPerforms != nil && !self.secondaryButtonText.isEmpty
    }
    
    // MARK: - COMPONENTS
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.setSquareView(with: AlertViewConstants.ViewModifiers.imageSize)
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyLFont(type: .Bold)
        label.textColor = .primary
        label.numberOfLines = AlertViewConstants.ViewModifiers.maxTitleLinesNumber
        label.textAlignment = .center
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyFont(type: .Medium)
        label.textColor = .primary
        label.numberOfLines = AlertViewConstants.ViewModifiers.maxBodyLinesNumber
        label.textAlignment = .center
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    private let primaryButton: CustomButton = {
        let button = CustomButton()
        button.setUp(type: .Primary)
        return button
    }()

    private let textButton: CustomButton = {
        let button = CustomButton()
        button.setUp(type: .Text)
        return button
    }()
    
    private lazy var closeButton: UIButton = {
        let button  = UIButton(type: .custom)
        button.setImage(.close, for: .normal)
        button.setSquareView(with: AlertViewConstants.ViewModifiers.closeButtonSize)
        button.addTarget(self, action: #selector(onClose), for: .touchUpInside)
        return button
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .background
        view.layer.cornerRadius = AlertViewConstants.ViewModifiers.cornerRadius

        let stack = UIStackView(
            arrangedSubviews: [
                self.imageView,
                self.titleLabel,
                self.bodyLabel
            ]
        )
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .equalSpacing
        stack.alignment = .center

        if self.hasPrimaryButton { stack.addArrangedSubview(self.primaryButton) }
        if self.hasSecondaryButton { stack.addArrangedSubview(self.textButton) }
        
        view.addSubview(stack)
        stack.setConstraints(
            top: view.topAnchor,
            paddingTop: 16,
            bottom: view.bottomAnchor,
            paddingBottom: 16,
            left: view.leftAnchor,
            paddingLeft: 16,
            right: view.rightAnchor,
            paddingRight: 16
        )
        view.addSubview(self.closeButton)
        self.closeButton.setConstraints(
            top: view.topAnchor,
            paddingTop: 16,
            right: view.rightAnchor,
            paddingRight: 16
        )
        return view
    }()

    // MARK: - INIT
    convenience init(
        image: UIImage,
        title: String,
        body: String,
        primaryButtonText: String,
        primaryPerforms: @escaping (() -> Void),
        additionalCloseAction: (() -> Void)? = nil
    ) {
        self.init()
        self.image = image
        self.titleText = title
        self.bodyText = body
        self.primaryButtonText = primaryButtonText
        self.primaryPerforms = primaryPerforms
        self.additionalCloseAction = additionalCloseAction
    }
    
    convenience init(
        image: UIImage,
        title: String,
        body: String,
        primaryButtonText: String,
        primaryPerforms: @escaping (() -> Void),
        secondaryButtonText: String,
        secondaryPerforms: @escaping (() -> Void),
        additionalCloseAction: (() -> Void)? = nil
    ) {
        self.init()
        self.image = image
        self.titleText = title
        self.bodyText = body
        self.primaryButtonText = primaryButtonText
        self.secondaryButtonText = secondaryButtonText
        self.primaryPerforms = primaryPerforms
        self.secondaryPerforms = secondaryPerforms
        self.additionalCloseAction = additionalCloseAction
    }
    
    convenience init(
        image: UIImage,
        title: String,
        body: String,
        secondaryButtonText: String,
        secondaryPerforms: @escaping (() -> Void),
        additionalCloseAction: (() -> Void)? = nil
    ) {
        self.init()
        self.image = image
        self.titleText = title
        self.bodyText = body
        self.secondaryButtonText = secondaryButtonText
        self.secondaryPerforms = secondaryPerforms
        self.additionalCloseAction = additionalCloseAction
    }
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureComponents()
        self.setUpUI()
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func configureComponents() {
        self.imageView.image = self.image
        self.titleLabel.text = self.titleText
        self.bodyLabel.text = self.bodyText
        self.primaryButton.setTitle(with: self.primaryButtonText)
        self.textButton.setTitle(with: self.secondaryButtonText)
        if let primaryAction = self.primaryPerforms {
            self.primaryButton.setAction { primaryAction() }
        }
        if let secondaryAction = self.secondaryPerforms {
            self.textButton.setAction { secondaryAction() }
        }
    }
    
    private func setUpUI() {
        self.view.backgroundColor = .clear
        self.view.isOpaque = false
        self.view.addSubview(self.contentView)
        self.contentView.setConstraints(
            top: self.view.topAnchor,
            paddingTop: 16,
            bottom: self.view.safeAreaLayoutGuide.bottomAnchor,
            left: self.view.leftAnchor,
            paddingLeft: 16,
            right: self.view.rightAnchor,
            paddingRight: 16
        )
    }
    
    @objc private func onClose() {
        self.dismiss(animated: true) {
            guard let closeAction = self.additionalCloseAction else { return }
            closeAction()
        }
    }
}

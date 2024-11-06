//
//  MovieDetailViewController.swift
//  TestPepe
//
//  Created by José De Jesús Vega López on 04/11/24.
//

import UIKit

class MovieDetailViewController: BaseViewController {
    
    // MARK: - PUBLIC PROPERTIES
    let viewModel = MovieDetailViewModel()
    
    // MARK: - COMPONENTS
    private let backDrop: UIImageView = {
        let image = UIImageView()
        image.setWidth(width: UIScreen.screenWidth)
        image.setHeight(height: 200)
        return image
    }()
    
    private let banner: UIImageView = {
        let image = UIImageView()
        image.setWidth(width: 120)
        image.setHeight(height: 100)
        return image
    }()
    
    private lazy var avatarNameView: AvatarName = {
        let view = AvatarName()
        view.setUp(
            avatar: self.viewModel.movieAvatar,
            name: self.viewModel.movieTitle,
            product: self.viewModel.movieReleaseDate
        )
        return view
    }()
    
    private lazy var recommendedView: RequerimentView = {
        let view = RequerimentView()
        view.setDescription(with: self.viewModel.recommendedDescription)
        view.isCheck(with: self.viewModel.recommended)
        return view
    }()
    
    private lazy var voteAverageLabel: UILabel = {
        let label = UILabel()
        label.font = .bodySFont(type: .Medium)
        label.textColor = .primary
        label.text = self.viewModel.voteAverage
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var bannerAvatarContent: UIStackView = {
        let starIcon = UIImage(systemName: "star.fill") ?? .checkmark
        starIcon.withRenderingMode(.alwaysTemplate)
        let star = UIImageView(image: starIcon)
        star.tintColor = .systemYellow
        star.setSquareView(with: 10)
        
        let averageStack = UIStackView(arrangedSubviews: [
            star,
            self.voteAverageLabel
        ])
        averageStack.axis = .horizontal
        averageStack.distribution = .fill

        let horizontalStack = UIStackView(arrangedSubviews: [
            self.recommendedView,
            averageStack
        ])
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = 8
        horizontalStack.distribution = .fill
        horizontalStack.alignment = .center
        
        let verticalStack = UIStackView(arrangedSubviews: [
            self.avatarNameView,
            horizontalStack
        ])
        verticalStack.axis = .vertical
        verticalStack.spacing = 8
        verticalStack.distribution = .fill
        verticalStack.alignment = .leading
        
        let stack = UIStackView(arrangedSubviews: [
            self.banner,
            verticalStack
        ])
        stack.axis = .horizontal
        stack.spacing = 0
        stack.distribution = .fill
        stack.alignment = .center
        return stack
    }()
    
    private lazy var descriptionView: DescriptionView = {
        let view = DescriptionView()
        view.configure(
            title: "Description",
            description: self.viewModel.description,
            buttonTitle: "More",
            buttonAction: { self.showMoreDescription() }
        )
        view.setWidth(width: UIScreen.screenWidth)
        return view
    }()
    
    private lazy var adultsView: RequerimentView = {
        let view = RequerimentView()
        let data = self.viewModel.adultsOnly
        if data.ban {
            view.setHasAlert(with: data.title)
        }
        else {
            view.setDescription(with: data.title)
            view.isCheck(with: true)
        }
        return view
    }()
    
    private lazy var popularView: RequerimentView = {
        let view = RequerimentView()
        let data = self.viewModel.isPopular
        if data.ban {
            view.setDescription(with: data.title)
            view.isCheck(with: true)
        }
        else {
            view.setHasAlert(with: data.title)
        }
        return view
    }()

    private lazy var adultsPopularStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            self.adultsView,
            self.popularView
        ])
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .equalSpacing
        stack.alignment = .center
        return stack
    }()
    
    private lazy var primaryButton: CustomButton = {
        let button = CustomButton()
        button.setUp(type: .Primary, title: "Watch trailer")
        button.setIcon(with: .init(systemName: "play.fill") ?? .add)
        button.setAction { self.showTrailer() }
        return button
    }()
    
    private lazy var secondaryButton: CustomButton = {
        let button = CustomButton()
        button.setUp(type: .Secondary, title: "Watch streaming")
        button.setAction { self.showStreaming() }
        return button
    }()
    
    private lazy var buttonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            self.primaryButton,
            self.secondaryButton
        ])
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .equalSpacing
        stack.alignment = .center
        return stack
    }()
            
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            self.backDrop,
            self.bannerAvatarContent,
            self.descriptionView,
            self.adultsPopularStack,
            self.buttonStack
        ])
        stack.setWidth(width: UIScreen.screenWidth)
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fill
        stack.alignment = .center
        return stack
    }()

    private lazy var scrollView: DynamicHeightScrollView = {
        let scroll = DynamicHeightScrollView(contentView: self.contentStack)
        return scroll
    }()
        
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getImages()
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func setUpUi() {
        self.title = "Detail"
        self.view.addSubview(scrollView)
        scrollView.setConstraints(
            top: self.view.topAnchor,
            bottom: self.view.safeAreaLayoutGuide.bottomAnchor,
            left: self.view.leftAnchor,
            right: self.view.rightAnchor
        )
    }
    
    private func getImages() {
        super.showLoader()
        self.backDrop.downloadImage(
            from: "https://image.tmdb.org/t/p/original\(self.viewModel.movieBackdrop)",
            contentMode: .scaleAspectFit
        )
        self.banner.downloadImage(from: "https://image.tmdb.org/t/p/original\(self.viewModel.movieBanner)")
        super.dismissLoader()
    }
    
    private func showMoreDescription() {
        super.showLoader()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let alertView = AlertView(
                image: .alert,
                title: "This request has timed out.",
                body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat",
                primaryButtonText: "Dismiss",
                primaryPerforms: { self.dismiss(animated: true) }
            )
            super.dismissLoader()
            Navigation.navigate(to: alertView, from: self, using: .presentBottomSheet)
        }
    }
    
    private func showTrailer() {
        super.showLoader()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let alertView = AlertView(
                image: .alert,
                title: self.viewModel.trailerAlert.title,
                body: self.viewModel.trailerAlert.body,
                secondaryButtonText: "Dimiss",
                secondaryPerforms: { self.dismiss(animated: true) }
            )
            super.dismissLoader()
            Navigation.navigate(to: alertView, from: self, using: .presentBottomSheet)
        }
    }
    
    private func showStreaming() {
        super.showLoader()
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            let alertView = AlertView(
                image: .alert,
                title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat",
                body: "To see a movie via streaming you need a subscription",
                primaryButtonText: "Sign up",
                primaryPerforms: { self.dismiss(animated: true) },
                secondaryButtonText: "Log in",
                secondaryPerforms: { self.dismiss(animated: true) }
            )
            super.dismissLoader()
            Navigation.navigate(to: alertView, from: self, using: .presentBottomSheet)
        }
    }
}

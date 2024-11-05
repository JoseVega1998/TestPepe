//
//  MovieDetailViewController.swift
//  TestPepe
//
//  Created by José De Jesús Vega López on 04/11/24.
//

import UIKit

class MovieDetailViewController: BaseViewController {
    
    private let viewModel: MovieDetailViewModel
    
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
    
    private lazy var bannerAvatarContent: UIStackView = {
        let verticalStack = UIStackView(arrangedSubviews: [
            self.avatarNameView,
            self.recommendedView
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
        view.setWidth(width: UIScreen.screenWidth)
        view.configure(title: "Description", description: self.viewModel.description)
        return view
    }()
            
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            self.backDrop,
            self.bannerAvatarContent,
            self.descriptionView
        ])
        stack.setWidth(width: UIScreen.screenWidth)
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fill
        stack.alignment = .leading
        return stack
    }()

    private lazy var scrollView: DynamicHeightScrollView = {
        let scroll = DynamicHeightScrollView(contentView: self.contentStack)
        return scroll
    }()
    
    init?(coder: NSCoder, movie: MovieListResponse.MovieList) {
        self.viewModel = MovieDetailViewModel(movie: movie)
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("ViewController resign")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getImages()
    }
    
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
    
}

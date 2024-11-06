//
//  MovieListViewController.swift
//  TestPepe
//
//  Created by José De Jesús Vega López on 04/11/24.
//

import UIKit

class MovieListViewController: BaseViewController {
    
    // MARK: - PUBLIC PROPERTIES
    let viewModel = MovieListViewModel()
    
    // MARK: - PRIVATE PROPERTIES
    private let refreshControl = UIRefreshControl()
    
    // MARK: - COMPONENTS
    private lazy var movieTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.separatorStyle = .singleLine
        table.backgroundColor = .clear
        table.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.id)
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyFont(type: .Bold)
        label.textColor = .primary
        label.numberOfLines = 2
        label.text = "Oops...\nSorry, we couldn't find any movies."
        label.textAlignment = .center
        return label
    }()
        
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.disableBack()
        self.setUpUi()
        self.configureComponents()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.getMovieList()
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func disableBack() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        guard let nv = self.navigationController else { return }
        nv.navigationItem.backBarButtonItem?.isEnabled = false
        nv.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    private func setUpUi() {
        self.title = "Top Rated Movies"
        self.view.addSubview(self.movieTableView)
        self.movieTableView.setConstraints(
            top: self.view.safeAreaLayoutGuide.topAnchor,
            bottom: self.view.safeAreaLayoutGuide.bottomAnchor,
            left: self.view.leftAnchor,
            right: self.view.rightAnchor
        )
    }
    
    private func configureComponents() {
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        self.movieTableView.addSubview(self.refreshControl)
    }
    
    @objc private func refresh(_ sender: AnyObject) {
        Task {
            do {
                try await self.viewModel.getMovieList(resetModel: true)
                self.reloadData()
                self.refreshControl.endRefreshing()
            }
            catch {
                let alertView = AlertView(
                    image: .alert,
                    title: "Oops",
                    body: error.localizedDescription,
                    primaryButtonText: "Dismiss",
                    primaryPerforms: { self.dismiss(animated: true)}
                )
                super.dismissLoader()
                Navigation.navigate(to: alertView, from: self, using: .presentBottomSheet)
            }
        }
    }
    
    private func getMovieList() {
        Task {
            do {
                super.showLoader()
                try await self.viewModel.getMovieList(resetModel: true)
                self.reloadData()
                super.dismissLoader()
            }
            catch {
                let alertView = AlertView(
                    image: .alert,
                    title: "Oops",
                    body: error.localizedDescription,
                    primaryButtonText: "Dismiss",
                    primaryPerforms: { self.dismiss(animated: true)}
                )
                super.dismissLoader()
                Navigation.navigate(to: alertView, from: self, using: .presentBottomSheet)
            }
        }
    }
    
    private func reloadData() {
        self.movieTableView.reloadData()
        switch self.viewModel.stateView {
        case .empty:
            self.movieTableView.backgroundView = self.emptyLabel
            self.movieTableView.separatorStyle = .none
        case .hasContent: break
        }
    }
}

// MARK: - UITableViewDelegate
extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.routeToMovieDetail(index: indexPath.row)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        let bounds = scrollView.bounds
        let size = scrollView.contentSize
        let inset = scrollView.contentInset
        let y = CGFloat(offset.y + bounds.size.height - inset.bottom)
        let h = CGFloat(size.height)
        let reload_distance = CGFloat(10)
        if(y > (h + reload_distance)) {
            if self.viewModel.hasMoreItems {
                Task {
                    do {
                        try await self.viewModel.getMovieList(resetModel: false)
                        self.reloadData()
                    }
                    catch {
                        let alertView = AlertView(
                            image: .alert,
                            title: "Oops",
                            body: error.localizedDescription,
                            primaryButtonText: "Dismiss",
                            primaryPerforms: { self.dismiss(animated: true)}
                        )
                        super.dismissLoader()
                        Navigation.navigate(to: alertView, from: self, using: .presentBottomSheet)
                    }
                }
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.id, for: indexPath) as! MovieTableViewCell
        let data = self.viewModel.movieList[indexPath.row]
        cell.configData(
            banner: data.posterPath ?? "",
            title: data.title ?? "",
            releaseDate: data.releaseDate ?? "",
            voteAverage: data.voteAverage ?? 0.0,
            voteCount: data.voteCount ?? 0
        )
        return cell
    }
    
}

//
//  MovieListViewController.swift
//  TestPepe
//
//  Created by José De Jesús Vega López on 04/11/24.
//

import UIKit

class MovieListViewController: BaseViewController {
    
    private let viewModel = MovieListViewModel()
    private let refreshControl = UIRefreshControl()
    
    private lazy var movieTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.separatorStyle = .singleLine
        table.backgroundColor = .clear
        table.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.id)
        table.delegate = self
        table.dataSource = self
        return table
    }()
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    deinit {
        print("ViewController resign")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUi()
        self.configureComponents()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.getMovieList()
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
    
    @objc func refresh(_ sender: AnyObject) {
        Task {
            do {
                try await self.viewModel.getMovieList(resetModel: true)
                self.movieTableView.reloadData()
                self.refreshControl.endRefreshing()
            }
            catch {
                print(error)
            }
        }
    }
    
    private func getMovieList() {
        Task {
            do {
                super.showLoader()
                try await self.viewModel.getMovieList(resetModel: true)
                self.movieTableView.reloadData()
                super.dismissLoader()
            }
            catch {
                print(error)
            }
        }
    }
}

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = self.viewModel.movieList[indexPath.row]
        Navigation.navigate(
            to: Navigation.createMovieDetailVc(movie: data),
            from: self,
            using: .push
        )
        
        // TEST ALERTS
        if indexPath.row == 0 {
            
        }
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
                        try await self.viewModel.getMovieList(resetModel: true)
                        self.movieTableView.reloadData()
                    }
                    catch {
                        print(error)
                    }
                }
            }
        }
    }
}

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

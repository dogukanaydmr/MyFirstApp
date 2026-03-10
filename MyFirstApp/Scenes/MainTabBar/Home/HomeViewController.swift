//
//  HomeViewController.swift
//  MyFirstApp
//
//  Created by Doğukan Aydemir on 9.03.2026.
//

import UIKit

final class HomeViewController: BaseViewController {
        
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FeedPostCell.self, forCellReuseIdentifier: FeedPostCell.identifier)
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 500
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let viewModel: HomeViewModelProtocol
    
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureTableView()
    }
}

extension HomeViewController: FeedPostCellDelegate {
    func feedPostCellDidTapLike(_ cell: FeedPostCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        var post = viewModel.posts[indexPath.row]
        post.isLiked.toggle()
        
        if post.isLiked {
            post.likeCount += 1
        } else {
            post.likeCount -= 1
        }
                
        cell.updateLikeState(isLiked: post.isLiked, likeCount: post.likeCount)
    }
    
    func feedPostCellDidTapComment(_ cell: FeedPostCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        print("Yorum butonuna basıldı: \(indexPath.row)")
    }
    
    func feedPostCellDidTapShare(_ cell: FeedPostCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        print("Paylaş butonuna basıldı: \(indexPath.row)")
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedPostCell.identifier, for: indexPath) as? FeedPostCell else {
            return UITableViewCell()
        }
        
        let model = viewModel.posts[indexPath.row]
        cell.configure(with: model)
        cell.delegate = self
        return cell
    }
}

private extension HomeViewController {
    
    func setupUI() {
        title = "Anasayfa"
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
}

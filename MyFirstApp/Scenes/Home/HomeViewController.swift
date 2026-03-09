//
//  HomeViewController.swift
//  MyFirstApp
//
//  Created by Doğukan Aydemir on 9.03.2026.
//

import UIKit

final class HomeViewController: UIViewController {
    
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
    }
}


private extension HomeViewController {
    
    func setupUI() {
        
    }
}

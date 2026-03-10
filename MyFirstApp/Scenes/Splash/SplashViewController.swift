//
//  ViewController.swift
//  MyFirstApp
//
//  Created by Doğukan Aydemir on 9.03.2026.
//

import UIKit

protocol SplashViewControllerDelegate: AnyObject {
    func splashViewController(_ controller: SplashViewController, didDetermine route: SplashRoute)
}

final class SplashViewController: BaseViewController {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Splash"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let viewModel: SplashViewModelProtocol
    var onRouteSelected: ((SplashRoute) -> Void)?
    weak var delegate: SplashViewControllerDelegate?
    
    init(viewModel: SplashViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        checkInitialRoute()
    }
}

private extension SplashViewController {
    
    func setupUI() {
        view.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func checkInitialRoute() {
        viewModel.decideInitialRoute { [weak self] route in
            guard let self else { return }
            delegate?.splashViewController(self, didDetermine: route)
        }
    }
}

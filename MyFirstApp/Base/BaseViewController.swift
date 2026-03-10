//
//  BaseViewController.swift
//  MyFirstApp
//
//  Created by Doğukan Aydemir on 10.03.2026.
//

import UIKit

class BaseViewController: UIViewController {
        
    private var loadingContainerView: UIView?
    private var loadingIndicator: UIActivityIndicatorView?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        setupViews()
        setupConstraints()
        setupBindings()
        setupActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewWillAppearActions()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewDidAppearActions()
    }
        
    func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    func setupViews() { }
    
    func setupConstraints() { }
    
    func setupBindings() { }
    
    func setupActions() { }
    
    func viewWillAppearActions() { }
    
    func viewDidAppearActions() { }
}

// MARK: - Loading

extension BaseViewController {
    
    func showLoading() {
        hideLoading()
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        containerView.isUserInteractionEnabled = true
        
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        
        view.addSubview(containerView)
        containerView.addSubview(indicator)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            indicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        loadingContainerView = containerView
        loadingIndicator = indicator
    }
    
    func hideLoading() {
        loadingIndicator?.stopAnimating()
        loadingIndicator?.removeFromSuperview()
        loadingContainerView?.removeFromSuperview()
        
        loadingIndicator = nil
        loadingContainerView = nil
    }
}

// MARK: - Alert

extension BaseViewController {
    
    func showAlert(
        title: String,
        message: String,
        buttonTitle: String = "Tamam",
        completion: (() -> Void)? = nil
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(title: buttonTitle, style: .default) { _ in
            completion?()
        }
        
        alert.addAction(action)
        present(alert, animated: true)
    }
}

// MARK: - Keyboard

extension BaseViewController {
    
    func enableKeyboardDismissOnTap() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        gesture.cancelsTouchesInView = false
        view.addGestureRecognizer(gesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

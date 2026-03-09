//
//  AuthCoordinator.swift
//  MyFirstApp
//
//  Created by Doğukan Aydemir on 9.03.2026.
//

import UIKit

protocol AuthCoordinatorDelegate: AnyObject {
    func authCoordinatorDidFinishLogin(_ coordinator: AuthCoordinator)
}

final class AuthCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    weak var delegate: AuthCoordinatorDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showLogin()
    }
}

private extension AuthCoordinator {
    func showLogin() {
        let viewModel = LoginViewModel()
        let viewController = LoginViewController(viewModel: viewModel)
        
        viewModel.delegate = viewController
        viewController.delegate = self
        
        navigationController.setViewControllers([viewController], animated: false)
    }
}

extension AuthCoordinator: LoginViewControllerDelegate {
    
    func loginViewControllerDidCompleteLogin(_ controller: LoginViewController) {
        delegate?.authCoordinatorDidFinishLogin(self)
    }
}

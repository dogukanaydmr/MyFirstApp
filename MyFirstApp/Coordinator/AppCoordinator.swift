//
//  AppCoordinator.swift
//  MyFirstApp
//
//  Created by Doğukan Aydemir on 9.03.2026.
//

import UIKit

final class AppCoordinator: Coordinator {

    var navigationController: UINavigationController
    private var childCoordinators: [Coordinator] = []

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showSplash()
    }
}

private extension AppCoordinator {
    
    func removeChild(_ coordinator: Coordinator) {
        childCoordinators.removeAll { $0 === coordinator }
    }
    
    func showSplash() {
        let viewModel = SplashViewModel()
        let viewController = SplashViewController(viewModel: viewModel)
        viewController.delegate = self
        
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func startAuthCoordinator() {
        let authCoordinator = AuthCoordinator(navigationController: navigationController)
        authCoordinator.delegate = self
        childCoordinators.append(authCoordinator)
        authCoordinator.start()
    }
    
    func startMainTabCoordinator() {
        let mainTabCoordinator = MainTabCoordinator(navigationController: navigationController)
        childCoordinators.append(mainTabCoordinator)
        mainTabCoordinator.start()
    }
}

extension AppCoordinator: SplashViewControllerDelegate {
    func splashViewController(_ controller: SplashViewController, didDetermine route: SplashRoute) {
        switch route {
        case .login:
            startAuthCoordinator()
        case .home:
            startMainTabCoordinator()
        }
    }
}

extension AppCoordinator: AuthCoordinatorDelegate {
    
    func authCoordinatorDidFinishLogin(_ coordinator: AuthCoordinator) {
        removeChild(coordinator)
        startMainTabCoordinator()
    }
}

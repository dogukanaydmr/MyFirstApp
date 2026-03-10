//
//  AppCoordinator.swift
//  MyFirstApp
//
//  Created by Doğukan Aydemir on 9.03.2026.
//

import UIKit

final class AppCoordinator: Coordinator {

    private let window: UIWindow
    private var childCoordinators: [Coordinator] = []

    private var authNavigationController = UINavigationController()

    init(window: UIWindow) {
        self.window = window
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

        authNavigationController.setViewControllers([viewController], animated: false)
        window.rootViewController = authNavigationController
    }
    
    func startAuthCoordinator() {
        let authCoordinator = AuthCoordinator(navigationController: authNavigationController)
        authCoordinator.delegate = self
        childCoordinators.append(authCoordinator)
        authCoordinator.start()
    }
    
    func startMainTabCoordinator() {
        let mainTabCoordinator = MainTabCoordinator()
        mainTabCoordinator.delegate = self
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

extension AppCoordinator: MainTabCoordinatorDelegate {
    func mainTabCoordinatorDidFinishSetup(_ coordinator: MainTabCoordinator, tabBarController: UITabBarController) {
        window.rootViewController = tabBarController
        removeChild(coordinator)
    }
}

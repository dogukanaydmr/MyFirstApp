//
//  MainTabCoordinator.swift
//  MyFirstApp
//
//  Created by Doğukan Aydemir on 9.03.2026.
//

import UIKit

protocol MainTabCoordinatorDelegate: AnyObject {
    func mainTabCoordinatorDidFinishSetup(_ coordinator: MainTabCoordinator, tabBarController: UITabBarController)
}

final class MainTabCoordinator: Coordinator {

    weak var delegate: MainTabCoordinatorDelegate?

    func start() {
        showMain()
    }
}

private extension MainTabCoordinator {

    func showMain() {
        let tabBarController = MainTabBarController()

        let homeNavigation = makeNavigationController(viewController: HomeViewController(viewModel: HomeViewModel()))
        let profileNavigation = makeNavigationController(viewController: ProfileViewController(viewModel: ProfileViewModel()))

        tabBarController.setViewControllers([homeNavigation, profileNavigation], animated: false)
        delegate?.mainTabCoordinatorDidFinishSetup(self, tabBarController: tabBarController)
    }
    
    func makeNavigationController(viewController: UIViewController) -> UINavigationController {
        UINavigationController(rootViewController: viewController)
    }
}

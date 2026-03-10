//
//  MainTabCoordinator.swift
//  MyFirstApp
//
//  Created by Doğukan Aydemir on 9.03.2026.
//

import UIKit

final class MainTabCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showMain()
    }
}

private extension MainTabCoordinator {
    
    func showMain() {
        let tabBarController = MainTabBarController()
        navigationController.setViewControllers([tabBarController], animated: false)
    }
}

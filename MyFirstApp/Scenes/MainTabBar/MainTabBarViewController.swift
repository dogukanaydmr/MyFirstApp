//
//  MainTabBarViewController.swift
//  MyFirstApp
//
//  Created by Doğukan Aydemir on 10.03.2026.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        setupAppearance()
    }
}

private extension MainTabBarController {
    
    func setupTabs() {
        let homeViewModel = HomeViewModel()
        let homeVC = HomeViewController(viewModel: homeViewModel)
        
        let profileVC = ProfileViewController()
        
        let homeNavController = UINavigationController(rootViewController: homeVC)        
        let profileNavController = UINavigationController(rootViewController: profileVC)
        
        homeNavController.tabBarItem = UITabBarItem(
            title: "Anasayfa",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        profileNavController.tabBarItem = UITabBarItem(
            title: "Profil",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )
        
        viewControllers = [homeNavController, profileNavController]
    }
    
    func setupAppearance() {
        tabBar.backgroundColor = .systemBackground
        tabBar.tintColor = .label
        tabBar.unselectedItemTintColor = .systemGray
    }
}

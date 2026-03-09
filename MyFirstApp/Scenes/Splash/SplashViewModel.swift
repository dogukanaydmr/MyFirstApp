//
//  SplashViewModel.swift
//  MyFirstApp
//
//  Created by Doğukan Aydemir on 9.03.2026.
//

import Foundation

protocol SplashViewModelProtocol {
    func decideInitialRoute(completion: @escaping (SplashRoute) -> Void)
}

final class SplashViewModel: SplashViewModelProtocol {
    
    func decideInitialRoute(completion: @escaping (SplashRoute) -> Void) {
        let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        let route: SplashRoute = isLoggedIn ? .home : .login
        completion(route)
    }
}

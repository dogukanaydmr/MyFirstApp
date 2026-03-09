//
//  LoginViewModel.swift
//  MyFirstApp
//
//  Created by Doğukan Aydemir on 9.03.2026.
//

protocol LoginViewModelDelegate: AnyObject {
    func loginViewModelDidLoginSuccessfully()
    func loginViewModelDidFail(with error: String)
}

protocol LoginViewModelProtocol: AnyObject {
    var delegate: LoginViewModelDelegate? { get set }
    func didTapLogin()
}

final class LoginViewModel: LoginViewModelProtocol {
    
    weak var delegate: LoginViewModelDelegate?
    
    func didTapLogin() {
        let isLoginSuccessful = true
        
        if isLoginSuccessful {
            delegate?.loginViewModelDidLoginSuccessfully()
        } else {
            delegate?.loginViewModelDidFail(with: "Giriş başarısız")
        }
    }
}

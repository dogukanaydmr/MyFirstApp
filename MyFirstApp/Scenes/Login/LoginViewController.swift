//
//  LoginViewController.swift
//  MyFirstApp
//
//  Created by Doğukan Aydemir on 9.03.2026.
//

import UIKit

protocol LoginViewControllerDelegate: AnyObject {
    func loginViewControllerDidCompleteLogin(_ controller: LoginViewController)
}

final class LoginViewController: UIViewController {
    
    private lazy var accountTextField: MyTextField = {
        let textField = MyTextField()
        textField.configure(placeholder: "Kullanıcı Adı")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var passwordTextField: MyTextField = {
        let textField = MyTextField()
        textField.configure(placeholder: "Şifre")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var textFieldStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 36.0
        stackView.addArrangedSubviews([accountTextField, passwordTextField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var loginButton: MyButton = {
        let button = MyButton()
        button.configure(title: "Giriş yap", isActive: true)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: LoginViewControllerDelegate?
    private let viewModel: LoginViewModelProtocol
    
    init(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupKeyboardDismiss()
    }
}

private extension LoginViewController {
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(textFieldStack)
        view.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            textFieldStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            textFieldStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textFieldStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24)
        ])
    }
    
    func setupKeyboardDismiss() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func didTapLogin() {
        viewModel.didTapLogin()
    }
}

extension LoginViewController: LoginViewModelDelegate {
    
    func loginViewModelDidLoginSuccessfully() {
        delegate?.loginViewControllerDidCompleteLogin(self)
    }
    
    func loginViewModelDidFail(with error: String) {
        print(error)
    }
}

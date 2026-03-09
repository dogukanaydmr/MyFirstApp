//
//  MyTextField.swift
//  MyFirstApp
//
//  Created by Doğukan Aydemir on 9.03.2026.
//

import UIKit

final class MyTextField: UITextField {
    
    // MARK: - UI
    
    private let floatingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .systemBlue
        label.alpha = 0
        label.backgroundColor = .systemBackground
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Properties
    
    private let inactiveBorderColor = UIColor.systemGray4.cgColor
    private let activeBorderColor = UIColor.systemBlue.cgColor
    
    private let textInsets = UIEdgeInsets(top: 14, left: 16, bottom: 14, right: 16)
    private var floatingLabelTopConstraint: NSLayoutConstraint?
    
    private var storedPlaceholder: String = ""
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MyTextField {
    
    func commonInit() {
        borderStyle = .none
        backgroundColor = .clear
        font = .systemFont(ofSize: 16)
        textColor = .label
        
        layer.cornerRadius = 20
        layer.borderWidth = 1
        layer.borderColor = inactiveBorderColor
        clipsToBounds = false
        
        addSubview(floatingLabel)
        
        floatingLabelTopConstraint = floatingLabel.topAnchor.constraint(equalTo: topAnchor, constant: 14)
        
        NSLayoutConstraint.activate([
            floatingLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            floatingLabelTopConstraint!
        ])
        
        addTarget(self, action: #selector(editingDidBeginAction), for: .editingDidBegin)
        addTarget(self, action: #selector(editingDidEndAction), for: .editingDidEnd)
        addTarget(self, action: #selector(textDidChangeAction), for: .editingChanged)
    }
    
    @objc func editingDidBeginAction() {
        layer.borderColor = activeBorderColor
        showFloatingLabel()
    }
    
    @objc func editingDidEndAction() {
        layer.borderColor = inactiveBorderColor
        
        if text?.isEmpty ?? true {
            hideFloatingLabel()
        }
    }
    
    @objc func textDidChangeAction() {
        if text?.isEmpty == false {
            showFloatingLabel()
        } else if !isFirstResponder {
            hideFloatingLabel()
        }
    }
    
    func showFloatingLabel() {
        placeholder = ""
        
        UIView.animate(withDuration: 0.2) {
            self.floatingLabel.alpha = 1
            self.floatingLabelTopConstraint?.constant = -20
            self.layoutIfNeeded()
        }
    }
    
    func hideFloatingLabel() {
        placeholder = storedPlaceholder
        
        UIView.animate(withDuration: 0.2) {
            self.floatingLabel.alpha = 0
            self.floatingLabelTopConstraint?.constant = 14
            self.layoutIfNeeded()
        }
    }
}

extension MyTextField {
    
    func configure(placeholder: String) {
        self.storedPlaceholder = placeholder
        self.placeholder = placeholder
        self.floatingLabel.text = " \(placeholder) "
    }
    
    func updateFloatingLabelBackground(_ color: UIColor) {
        floatingLabel.backgroundColor = color
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: textInsets)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: textInsets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: textInsets)
    }
}

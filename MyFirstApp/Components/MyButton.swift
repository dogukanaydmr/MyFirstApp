//
//  MyButton.swift
//  MyFirstApp
//
//  Created by Doğukan Aydemir on 9.03.2026.
//

import UIKit

final class MyButton: UIButton {
    
    private var heightConstraint: NSLayoutConstraint?
    private var activeBackgroundColor: UIColor = .systemPurple
    private var inactiveBackgroundColor: UIColor = .systemGray4
    private var activeTitleColor: UIColor = .white
    private var inactiveTitleColor: UIColor = .systemPurple
    
    override var isEnabled: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func configure(title: String,
                   isActive: Bool,
                   activeBackgroundColor: UIColor = .systemPurple,
                   inactiveBackgroundColor: UIColor = .systemGray4,
                   activeTitleColor: UIColor = .white,
                   inactiveTitleColor: UIColor = .systemPurple) {
        setTitle(title, for: .normal)
        self.activeBackgroundColor = activeBackgroundColor
        self.inactiveBackgroundColor = inactiveBackgroundColor
        self.activeTitleColor = activeTitleColor
        self.inactiveTitleColor = inactiveTitleColor
        self.isEnabled = isActive
        updateAppearance()
    }
}

private extension MyButton {
    
    func commonInit() {
        heightConstraint = heightAnchor.constraint(equalToConstant: 48.0)
        heightConstraint?.isActive = true
        layer.cornerRadius = 24.0
        layer.masksToBounds = true

        titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        translatesAutoresizingMaskIntoConstraints = false
        
        updateAppearance()
    }
    
    func updateAppearance() {
        backgroundColor = isEnabled ? activeBackgroundColor : inactiveBackgroundColor
        setTitleColor(isEnabled ? activeTitleColor : inactiveTitleColor, for: .normal)
        alpha = isEnabled ? 1.0 : 1.0
    }
}

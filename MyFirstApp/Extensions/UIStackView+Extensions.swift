//
//  UIStackView+Extensions.swift
//  MyFirstApp
//
//  Created by Doğukan Aydemir on 9.03.2026.
//

import UIKit

extension UIStackView {
    
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { addArrangedSubview($0) }
    }
}

//
//  UIView+constraints.swift
//  CATGanisation
//
//  Created by Adrian Popovici on 16.09.2021.
//

import UIKit

extension UIView {

    func embed(_ subview: UIView, inset: UIEdgeInsets = .zero) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset.left),
            subview.topAnchor.constraint(equalTo: topAnchor, constant: inset.top),
            subview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset.right),
            subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset.bottom)
        ])
    }

    func embedBorderBottom(_ subview: UIView, inset: UIEdgeInsets = .zero) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset.left),
            subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: inset.top),
            subview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset.right),
            subview.heightAnchor.constraint(equalToConstant: 1)
        ])
    }

    func embedTopSafeArea(_ subview: UIView, inset: UIEdgeInsets = .zero) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset.left),
            subview.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: inset.top),
            subview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset.right),
            subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset.bottom)
        ])
    }
}

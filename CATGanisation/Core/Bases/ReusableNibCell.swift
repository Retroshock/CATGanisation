//
//  ReusableNibCell.swift
//  CATGanisation
//
//  Created by Adrian Popovici on 16.09.2021.
//

import UIKit

protocol ReusableNibCell {
    static var identifier: String { get }
    static var nib: UINib { get }
}

extension ReusableNibCell {
    static var identifier: String {
        return String(describing: self)
    }

    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}

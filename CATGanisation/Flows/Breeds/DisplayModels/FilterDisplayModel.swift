//
//  FilterDisplayModel.swift
//  CATGanisation
//
//  Created by Adrian Popovici on 17.09.2021.
//

import Foundation

struct FilterDisplayModel: Hashable {
    let name: String
    var isSelected: Bool = false

    mutating func select() {
        self.isSelected.toggle()
    }
}

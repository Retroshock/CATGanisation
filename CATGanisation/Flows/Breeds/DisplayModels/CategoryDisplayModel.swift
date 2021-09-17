//
//  CategoryDisplayModel.swift
//  CATGanisation
//
//  Created by Adrian Popovici on 17.09.2021.
//

import Foundation

struct CategoryDisplayModel {
    let id: Int
    let name: String
    var isSelected: Bool = false

    mutating func select() {
        self.isSelected.toggle()
    }
}

//
//  MoviesState.swift
//  ARating
//
//  Created by Nikita Gavrikov on 29.06.2022.
//

import UIKit

final class TabBarState {
    var items: [TabBarCellModel]
    var selectedCell: Int = 0
    var embeddedView: UIView?

    init(items: [TabBarCellModel]) {
        self.items = items
    }
}

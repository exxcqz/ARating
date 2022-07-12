//
//  MoviesState.swift
//  ARating
//
//  Created by Nikita Gavrikov on 29.06.2022.
//

import UIKit

final class TabBarState {
    var items: [TabBarModel]
    var viewControllers: [UINavigationController] = []

    init(items: [TabBarModel]) {
        self.items = items
    }
}

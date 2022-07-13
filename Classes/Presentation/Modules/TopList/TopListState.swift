//
//  MoviesState.swift
//  ARating
//
//  Created by Nikita Gavrikov on 29.06.2022.
//

import Foundation

final class TopListState {
    var items: [TopListCellModel] = []
    var currentPage: Int = 1
    var totalPage: Int = 1
    var isEventScroll: Bool = false
    var searchModeActivated: Bool = false
    var query: String = ""
}

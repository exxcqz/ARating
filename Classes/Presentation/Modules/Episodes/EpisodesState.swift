//
//  EpisodesState.swift
//  ARating
//
//  Created by Nikita Gavrikov on 14.07.2022.
//

import Foundation

final class EpisodesState {
    var id: Int
    var title: String
    var currentPage: Int = 1
    var totalPage: Int = 1
    var items: [EpisodesCellModel] = []

    init(id: Int, title: String) {
        self.id = id
        self.title = title
    }
}

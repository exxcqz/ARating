//
//  Episodes.swift
//  ARating
//
//  Created by Nikita Gavrikov on 14.07.2022.
//

import Foundation

struct Episodes: Codable {
    let pagination: EpisodesPagination
    let data: [EpisodeModel]
}

struct EpisodesPagination: Codable {
    let totalPage: Int

    enum CodingKeys: String, CodingKey {
        case totalPage = "last_visible_page"
    }
}

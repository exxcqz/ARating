//
//  PagingInfo.swift
//  ARating
//
//  Created by Nikita Gavrikov on 29.06.2022.
//

import Foundation

struct PageInfo: Codable {
    let lastVisiblePage: Int
    let hasNextPage: Bool
    let currentPage: Int
    let items: PageItems

    enum CodingKeys: String, CodingKey {
        case lastVisiblePage = "last_visible_page"
        case hasNextPage = "has_next_page"
        case currentPage = "current_page"
        case items
    }
}

struct PageItems: Codable {
    let count: Int
    let total: Int
    let perPage: Int

    enum CodingKeys: String, CodingKey {
        case count, total
        case perPage = "per_page"
    }
}

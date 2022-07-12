//
//  RecommendedItem.swift
//  ARating
//
//  Created by Nikita Gavrikov on 12.07.2022.
//

import Foundation

struct RecommendationItem: Codable {
    let entry: RecommendedAnime
    let url: String
    let votes: Int
}

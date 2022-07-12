//
//  RecommendedAnime.swift
//  ARating
//
//  Created by Nikita Gavrikov on 12.07.2022.
//

import Foundation

struct RecommendedAnime: Codable {
    let id: Int
    let url: String
    let images: AnimeImages
    let title: String

    enum CodingKeys: String, CodingKey {
        case id = "mal_id"
        case url
        case images
        case title
    }
}

//
//  EpisodeModel.swift
//  ARating
//
//  Created by Nikita Gavrikov on 14.07.2022.
//

import Foundation

struct EpisodeModel: Codable {
    let id: Int
    let title: String?
    let aired: String?
    let score: Double?
    let filler: Bool

    enum CodingKeys: String, CodingKey {
        case id = "mal_id"
        case title
        case aired
        case score
        case filler
    }
}

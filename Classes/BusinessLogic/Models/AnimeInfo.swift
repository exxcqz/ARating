//
//  DataResult.swift
//  ARating
//
//  Created by Nikita Gavrikov on 29.06.2022.
//

import Foundation

struct AnimeInfo: Codable {
    let id: Int
    let images: AnimeImages
    let title: String?
    let englishTitle: String?
    let type: String?
    let source: String?
    let episodes: Int?
    let status: String?
    let score: Double?
    let rank: Int?
    let popularity: Int?
    let members: Int?
    let favorites: Int?
    let synopsis: String?
    let year: Int?
    let genres: [Genre]

    enum CodingKeys: String, CodingKey {
        case id = "mal_id"
        case images
        case title
        case englishTitle = "title_english"
        case episodes
        case type
        case source
        case status
        case score
        case rank
        case popularity
        case members
        case favorites
        case synopsis
        case year
        case genres
    }
}

struct AnimeImages: Codable {
    let jpg: ImagesData
}

struct ImagesData: Codable {
    let imageUrl: String
    let smallImageUrl: String
    let largeImageUrl: String

    enum CodingKeys: String, CodingKey {
        case imageUrl = "image_url"
        case smallImageUrl = "small_image_url"
        case largeImageUrl = "large_image_url"
    }
}

struct Genre: Codable {
    let id: Int
    let type: String
    let name: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case id = "mal_id"
        case type
        case name
        case url
    }
}

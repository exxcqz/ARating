//
//  FavoritesModel.swift
//  ARating
//
//  Created by Nikita Gavrikov on 07.07.2022.
//

import Foundation
import RealmSwift

class AnimeModel: Object {
    @Persisted var id: Int
    @Persisted var imageUrl: String
    @Persisted var largeImageUrl: String
    @Persisted var title: String?
    @Persisted var englishTitle: String?
    @Persisted var type: String?
    @Persisted var source: String?
    @Persisted var episodes: Int?
    @Persisted var status: String?
    @Persisted var score: Double?
    @Persisted var rank: Int?
    @Persisted var popularity: Int?
    @Persisted var members: Int?
    @Persisted var favorites: Int?
    @Persisted var synopsis: String?
    @Persisted var year: Int?
    @Persisted var genres = List<String>()

    convenience init(animeInfo: AnimeInfo) {
        self.init()
        self.id = animeInfo.id
        self.imageUrl = animeInfo.images.jpg.imageUrl
        self.largeImageUrl = animeInfo.images.jpg.largeImageUrl
        self.title = animeInfo.englishTitle ?? animeInfo.title ?? ""
        self.englishTitle = animeInfo.englishTitle
        self.type = animeInfo.type
        self.episodes = animeInfo.episodes
        self.status = animeInfo.status
        self.score = animeInfo.score
        self.rank = animeInfo.rank
        self.popularity = animeInfo.popularity
        self.members = animeInfo.members
        self.favorites = animeInfo.favorites
        self.synopsis = animeInfo.synopsis
        self.year = animeInfo.year
        let genresName = animeInfo.genres.map { $0.name }
        genres.append(objectsIn: genresName)
    }
}

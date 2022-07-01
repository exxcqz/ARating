//
//  AnimeDetailsState.swift
//  ARating
//
//  Created by Nikita Gavrikov on 30.06.2022.
//

import UIKit

final class AnimeDetailsState {
    var animeInfo: AnimeInfo

    var image: UIImage?
    var title: String
    var year: Int
    var rating: Double
    var synopsis: String
    var genres: String = ""

    init(animeInfo: AnimeInfo) {
        self.animeInfo = animeInfo
        self.title = animeInfo.englishTitle ?? animeInfo.title ?? ""
        self.year = animeInfo.year ?? 0
        self.rating = animeInfo.score ?? 0
        self.synopsis = animeInfo.synopsis ?? ""
    }
}

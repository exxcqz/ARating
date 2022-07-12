//
//  AnimeDetailsState.swift
//  ARating
//
//  Created by Nikita Gavrikov on 30.06.2022.
//

import UIKit

final class AnimeDetailsState {
    var animeModel: AnimeModel

    var recommendationsModels: [RecommendationsCellModel] = []
    var image: UIImage?
    var title: String
    var year: Int
    var rating: Double
    var synopsis: String
    var genres: String = ""
    var imageViewScale: CGFloat = 1
    var isNavigationBarHidden: Bool = true
    var isFavorite: Bool = false

    init(animeModel: AnimeModel) {
        self.animeModel = AnimeModel(value: animeModel)
        self.title = animeModel.englishTitle ?? animeModel.title ?? ""
        self.year = animeModel.year ?? 0
        self.rating = animeModel.score ?? 0
        self.synopsis = animeModel.synopsis ?? ""
    }
}

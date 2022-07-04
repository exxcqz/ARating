//
//  AnimeDetailsState.swift
//  ARating
//
//  Created by Nikita Gavrikov on 30.06.2022.
//

import UIKit

final class AnimeDetailsState {
    var animeModel: TopListCellModel

    var image: UIImage?
    var title: String
    var year: Int
    var rating: Double
    var synopsis: String
    var genres: String = ""

    init(animeModel: TopListCellModel) {
        self.animeModel = animeModel
        self.title = animeModel.title
        self.year = animeModel.year
        self.rating = animeModel.rating
        self.synopsis = animeModel.animeInfo.synopsis ?? ""
    }
}

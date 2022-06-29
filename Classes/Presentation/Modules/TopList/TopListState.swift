//
//  MoviesState.swift
//  ARating
//
//  Created by Nikita Gavrikov on 29.06.2022.
//

import Foundation

final class TopListState {
    var items: [TopListCellModel] = [
        TopListCellModel(image: Asset.test.image, title: "Batman Batman Batman Batman", year: 2008, rating: 10),
        TopListCellModel(image: Asset.test.image, title: "Batman", year: 2008, rating: 10),
        TopListCellModel(image: Asset.test.image, title: "Batman", year: 2008, rating: 10),
        TopListCellModel(image: Asset.test.image, title: "Batman", year: 2008, rating: 10),
        TopListCellModel(image: Asset.test.image, title: "Batman", year: 2008, rating: 10)
    ]
}

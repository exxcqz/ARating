//
//  TopListCellModel.swift
//  ARating
//
//  Created by Nikita Gavrikov on 29.06.2022.
//

import UIKit

final class TopListCellModel {
    var image: UIImage
    var title: String
    var year: Int
    var rating: Int

    init(image: UIImage, title: String, year: Int, rating: Int) {
        self.image = image
        self.title = title
        self.year = year
        self.rating = rating
    }
}

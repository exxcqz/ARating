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
    var rating: Double

    init(image: UIImage, title: String, year: Int, rating: Double) {
        self.image = image
        self.title = title
        self.year = year
        self.rating = rating
    }
}

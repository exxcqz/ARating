//
//  TabBarCellModel.swift
//  ARating
//
//  Created by Nikita Gavrikov on 29.06.2022.
//

import UIKit

final class TabBarModel {
    var viewController: UIViewController
    var image: UIImage
    var title: String
    var tag: Int

    init(viewController: UIViewController, image: UIImage, title: String, tag: Int) {
        self.viewController = viewController
        self.image = image
        self.title = title
        self.tag = tag
    }
}

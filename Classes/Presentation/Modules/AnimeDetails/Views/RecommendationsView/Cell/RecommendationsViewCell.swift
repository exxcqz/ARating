//
//  RecommendationsViewCell.swift
//  ARating
//
//  Created by Nikita Gavrikov on 12.07.2022.
//

import UIKit
import Framezilla

final class RecommendationsViewCell: UICollectionViewCell {

    // MARK: - Subviews

    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        return view
    }()

    //MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }

    // MARK: - Private

    private func setup() {
        addSubview(imageView)
    }
}

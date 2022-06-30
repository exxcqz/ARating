//
//  TabBarViewCell.swift
//  ARating
//
//  Created by Nikita Gavrikov on 29.06.2022.
//

import UIKit

final class TabBarViewCell: UICollectionViewCell {

    // MARK: - Subviews

    lazy var imageView: UIImageView = {
        let view = UIImageView()
        return view
    }()

    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = .proDisplayRegularFont(ofSize: 10)
        view.textColor = .main4A
        view.textAlignment = .center
        return view
    }()

    //MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(titleLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.configureFrame { maker in
            maker.sizeToFit()
                .top(inset: 9)
                .centerX()
        }

        titleLabel.configureFrame { maker in
            maker.sizeToFit()
                .top(to: imageView.nui_bottom, inset: 3)
                .centerX(to: imageView.nui_centerX)
        }
    }
}

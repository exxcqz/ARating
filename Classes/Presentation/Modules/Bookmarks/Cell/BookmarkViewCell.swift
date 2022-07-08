//
//  BookmarksViewCell.swift
//  ARating
//
//  Created by Nikita Gavrikov on 07.07.2022.
//

import UIKit
import Framezilla

final class BookmarkViewCell: UICollectionViewCell {

    // MARK: - Subviews

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        return view
    }()

    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        return view
    }()

    private lazy var ratingBackdropView: UIView = {
        let view = UIView()
        view.backgroundColor = .main3A
        return view
    }()

    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = .proDisplayMediumFont(ofSize: 14 * Layout.scaleFactorW)
        view.textColor = .main1A
        return view
    }()

    lazy var yearLabel: UILabel = {
        let view = UILabel()
        view.font = .proDisplayRegularFont(ofSize: 12)
        view.textColor = .main1A
        view.alpha = 0.8
        return view
    }()

    lazy var ratingLabel: UILabel = {
        let view = UILabel()
        view.font = .proDisplayMediumFont(ofSize: 14)
        view.textColor = .main2A
        view.textAlignment = .center
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
        containerView.frame = bounds

        imageView.configureFrame { maker in
            maker.size(width: bounds.height - 10, height: bounds.height - 10)
                .left(inset: 5)
                .centerY()
        }

        ratingBackdropView.configureFrame { maker in
            maker.size(width: 35, height: 19)
                .top(to: imageView.nui_top, inset: 5)
                .right(to: imageView.nui_right, inset: 5)
                .cornerRadius(3)
        }

        titleLabel.configureFrame { maker in
            maker.sizeThatFits(size: .init(width: bounds.width - imageView.frame.height - 20,
                                           height: 37 * Layout.scaleFactorW))
                .top(inset: 5)
                .left(to: imageView.nui_right, inset: 5)
                .right(inset: 10)
        }

        yearLabel.configureFrame { maker in
            maker.sizeToFit()
                .top(to: titleLabel.nui_bottom, inset: 5)
                .left(to: titleLabel.nui_left)
        }

        ratingLabel.configureFrame { maker in
            maker.sizeToFit()
                .center(to: ratingBackdropView)
        }
    }

    // MARK: - Private

    private func setup() {
        addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(ratingBackdropView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(yearLabel)
        containerView.addSubview(ratingLabel)
    }
}


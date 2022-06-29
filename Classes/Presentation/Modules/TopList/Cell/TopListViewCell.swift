//
//  TopListViewCell.swift
//  ARating
//
//  Created by Nikita Gavrikov on 29.06.2022.
//

import UIKit
import Framezilla

final class TopListViewCell: UICollectionViewCell {

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
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.main1B.cgColor,
                                UIColor.main1A.cgColor]
        gradientLayer.locations = [0.3, 1.0]
        view.layer.insertSublayer(gradientLayer, at: 0)
        return view
    }()

    private lazy var arcView: UIView = {
        let view = UIView()
        view.backgroundColor = .main3A
        return view
    }()

    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = .proDisplayBoldFont(ofSize: 12)
        view.textColor = .main2A
        return view
    }()

    lazy var yearLabel: UILabel = {
        let view = UILabel()
        view.font = .proDisplayRegularFont(ofSize: 12)
        view.textColor = .main2A
        view.alpha = 0.8
        return view
    }()

    lazy var ratingLabel: UILabel = {
        let view = UILabel()
        view.font = .proDisplayMediumFont(ofSize: 20)
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
        containerView.configureFrame { maker in
            maker.top()
                .left()
                .right()
                .bottom()
        }

        imageView.frame = containerView.bounds

        imageView.layer.sublayers?.configureFrames { maker in
            maker.height(bounds.height / 3.9)
                .left()
                .right()
                .bottom()
        }

        arcView.configureFrame { maker in
            maker.size(width: 30, height: 30)
                .top(to: containerView.nui_top, inset: 10)
                .right(to: containerView.nui_right, inset: 10)
                .cornerRadius(15)
        }

        titleLabel.configureFrame { maker in
            maker.sizeThatFits(size: .init(width: bounds.width - 20, height: 50))
                .left(to: containerView.nui_left, inset: 10)
                .right(to: containerView.nui_right,inset: 10)
                .bottom(to: containerView.nui_bottom, inset: 11)
        }

        yearLabel.configureFrame { maker in
            maker.sizeToFit()
                .left(to: containerView.nui_left, inset: 10)
                .bottom(to: titleLabel.nui_top, inset: 3)
        }

        ratingLabel.configureFrame { maker in
            maker.sizeToFit()
                .center(to: arcView)
        }
    }

    // MARK: - Private

    private func setup() {
        addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(arcView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(yearLabel)
        containerView.addSubview(ratingLabel)
    }
}

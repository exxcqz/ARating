//
//  EpisodesViewCell.swift
//  ARating
//
//  Created by Nikita Gavrikov on 14.07.2022.
//

import UIKit

final class EpisodesViewCell: UICollectionViewCell {

    // MARK: - Subviews

    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = .proDisplayBoldFont(ofSize: 13)
        view.textColor = .main1A
        view.textAlignment = .center
        return view
    }()

    lazy var scoreLabel: UILabel = {
        let view = UILabel()
        view.font = .proDisplayMediumFont(ofSize: 12)
        view.textColor = .main1A
        view.textAlignment = .center
        return view
    }()

    lazy var fillerLabel: UILabel = {
        let view = UILabel()
        view.font = .proDisplayMediumFont(ofSize: 12)
        view.textColor = .main1A
        view.textAlignment = .center
        return view
    }()

    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .main1A
        view.alpha = 0.4
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.configureFrame { maker in
            maker.heightToFit()
                .top()
                .left(inset: 20)
                .right(inset: 20)
        }

        scoreLabel.configureFrame { maker in
            maker.size(width: 100, height: 14)
                .top(to: titleLabel.nui_bottom, inset: 4)
                .centerX()
        }

        fillerLabel.configureFrame { maker in
            maker.size(width: 100, height: 14)
                .top(to: scoreLabel.nui_bottom, inset: 4)
                .centerX()
        }

        dividerView.configureFrame { maker in
            maker.height(1)
                .top(to: fillerLabel.nui_bottom, inset: 4)
                .left(inset: 20)
                .right(inset: 20)
                .cornerRadius(1)
        }
    }

    func changeFillerLabel(with fillerValue: Bool) {
        if fillerValue {
            fillerLabel.font = .proDisplayBoldFont(ofSize: 12)
            fillerLabel.textColor = .main3A
        }
        else {
            fillerLabel.font = .proDisplayMediumFont(ofSize: 12)
            fillerLabel.textColor = .main1A
        }
    }

    // MARK: - Private

    private func setup() {
        addSubview(titleLabel)
        addSubview(scoreLabel)
        addSubview(fillerLabel)
        addSubview(dividerView)
    }
}

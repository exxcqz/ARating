//
//  AnimeDetailsSeriesView.swift
//  ARating
//
//  Created by Nikita Gavrikov on 14.07.2022.
//

import UIKit
import Framezilla

final class AnimeDetailsEpisodesView: UIView {

    var tapHandler: (() -> Void)?

    // MARK: - Subviews

    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = .proDisplayBoldFont(ofSize: 20)
        view.text = "Episodes"
        view.textColor = .main1A
        view.textAlignment = .left
        return view
    }()

    lazy var episodesCountLabel: UILabel = {
        let view = UILabel()
        view.font = .proDisplayMediumFont(ofSize: 16)
        view.textColor = .main1A
        view.alpha = 0.5
        view.textAlignment = .left
        return view
    }()

    private lazy var openButton: UIButton = {
        let view = UIButton(type: .custom)
        view.setTitle("Check all", for: .normal)
        view.setTitleColor(.main3A, for: .normal)
        view.addTarget(self, action: #selector(openButtonTapped), for: .touchUpInside)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.configureFrame { maker in
            maker.size(width: 100, height: 22)
                .top()
                .left(inset: 30)
        }

        episodesCountLabel.configureFrame { maker in
            maker.size(width: 100, height: 18)
                .top(to: titleLabel.nui_bottom, inset: 5)
                .left(inset: 30)
        }

        openButton.configureFrame { maker in
            maker.size(width: 100, height: 30)
                .top()
                .right(inset: 5)
        }
    }

    @objc private func openButtonTapped() {
        tapHandler?()
    }

    private func setup() {
        addSubview(titleLabel)
        addSubview(episodesCountLabel)
        addSubview(openButton)
    }
}

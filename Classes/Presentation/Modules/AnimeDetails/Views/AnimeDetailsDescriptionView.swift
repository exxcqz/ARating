//
//  AnimeDetailsDescriptionView.swift
//  ARating
//
//  Created by Nikita Gavrikov on 15.07.2022.
//

import UIKit
import Framezilla

final class AnimeDetailsDescriptionView: UIView {

    var synopsisTapHandler: (() -> Void)?

    // MARK: - Subviews

    lazy var ratingLabel: UILabel = {
        let view = UILabel()
        view.font = .proDisplayBoldFont(ofSize: 15)
        view.textColor = .main1A
        view.textAlignment = .center
        return view
    }()

    lazy var genresLabel: UILabel = {
        let view = UILabel()
        view.font = .proTextSemiboldFont(ofSize: 13)
        view.textColor = .main1A
        view.textAlignment = .center
        return view
    }()

    lazy var synopsisLabel: UILabel = {
        let view = UILabel()
        view.font = .proDisplayRegularFont(ofSize: 18)
        view.numberOfLines = 0
        view.textColor = .main1A
        view.textAlignment = .left
        view.isUserInteractionEnabled = true
        return view
    }()

    lazy var synopsisButton: UIButton = {
        let view = UIButton(type: .custom)
        view.setTitle("Show all text", for: .normal)
        view.setTitleColor(.main3A, for: .normal)
        view.addTarget(self, action: #selector(synopsisTapped), for: .touchUpInside)
        return view
    }()

    private lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        return UITapGestureRecognizer(target: self, action: #selector(synopsisTapped))
    }()

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        ratingLabel.configureFrame { maker in
            maker.sizeToFit()
                .top()
                .centerX()
        }

        genresLabel.configureFrame { maker in
            maker.sizeToFit()
                .top(to: ratingLabel.nui_bottom, inset: 7)
                .left(inset: 30)
                .right(inset: 30)
                .centerX()
        }

        synopsisLabel.configureFrame { maker in
            maker.height(120)
                .top(to: genresLabel.nui_bottom, inset: 5)
                .left(inset: 30)
                .right(inset: 30)
        }

        synopsisButton.configureFrame { maker in
            maker.sizeToFit()
                .top(to: synopsisLabel.nui_bottom, inset: 3)
                .left(inset: 30)
        }
    }

    @objc private func synopsisTapped() {
        synopsisTapHandler?()
    }

    // MARK: - Private

    private func setup() {
        addSubview(ratingLabel)
        addSubview(genresLabel)
        addSubview(synopsisLabel)
        addSubview(synopsisButton)
        synopsisLabel.addGestureRecognizer(tapGestureRecognizer)
    }
}

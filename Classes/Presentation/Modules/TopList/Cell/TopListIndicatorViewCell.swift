//
//  TopListIndicatorViewCell.swift
//  ARating
//
//  Created by Nikita Gavrikov on 30.06.2022.
//

import UIKit
import Framezilla

final class TopListIndicatorViewCell: UICollectionViewCell {

    // MARK: - Subviews

    lazy var indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
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
        indicatorView.frame = .init(x: 0, y: 0, width: 30, height: 30)
        indicatorView.center = contentView.center
    }

    // MARK: - Private

    private func setup() {
        contentView.addSubview(indicatorView)
    }
}


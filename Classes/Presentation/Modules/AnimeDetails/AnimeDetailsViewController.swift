//
//  AnimeDetailsViewController.swift
//  ARating
//
//  Created by Nikita Gavrikov on 30.06.2022.
//

import UIKit
import Framezilla

protocol AnimeDetailsViewInput {
    func update(with state: AnimeDetailsState, force: Bool, animated: Bool)
}

final class AnimeDetailsViewController: UIViewController {
    var presenter: AnimeDetailsPresenter

    private var imageViewScale: CGFloat = 1

    // MARK: - Subviews

    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        return view
    }()

    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        return view
    }()

    private lazy var backdropView: UIView = {
        let view = UIView()
        view.backgroundColor = .main2A
        view.layer.cornerRadius = 10
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = .proDisplayBoldFont(ofSize: 23)
        view.numberOfLines = 0
        view.textColor = .main1A
        view.textAlignment = .center
        return view
    }()

    // MARK: - Lifecycle

    init(presenter: AnimeDetailsPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.configureFrame { maker in
            maker.size(width: 190 * Layout.scaleFactorW / imageViewScale,
                       height: 250 * Layout.scaleFactorH / imageViewScale)
                .top(to: view.nui_safeArea.top)
                .centerX()
        }

        scrollView.configureFrame { maker in
            maker.top().left().right().bottom()
        }

        backdropView.configureFrame { maker in
            maker.height(1200)
                .top().left().right()
        }

        scrollView.contentInset = .init(top: 340 * Layout.scaleFactorH, left: 0, bottom: 0, right: 0)
        scrollView.contentSize = backdropView.bounds.size

        titleLabel.configureFrame { maker in
            maker.sizeToFit()
                .top(inset: 10)
                .left(inset: 30)
                .right(inset: 30)
        }
    }

    // MARK: - Private

    private func setup() {
        view.backgroundColor = UIColor(r: 255, g: 255, b: 255, alpha: 0.7)
        view.addSubview(imageView)
        view.addSubview(scrollView)
        scrollView.addSubview(backdropView)
        backdropView.addSubview(titleLabel)
        scrollView.delegate = self
        presenter.viewDidLoad()
    }
}

// MARK: - TabBarViewInput

extension AnimeDetailsViewController: AnimeDetailsViewInput {

    func update(with state: AnimeDetailsState, force: Bool, animated: Bool) {
        imageView.image = state.image
        titleLabel.text = state.title
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
}

// MARK: - TabBarViewInput

extension AnimeDetailsViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scale = abs(scrollView.contentInset.top / scrollView.contentOffset.y)
        imageViewScale = scale
        view.setNeedsLayout()
        view.layoutIfNeeded()

    }
}

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

    private var imageViewScale: CGFloat {
        didSet {
            view.setNeedsLayout()
            view.layoutIfNeeded()
        }
    }

    // MARK: - Subviews

    private lazy var indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        return view
    }()

    private lazy var navigationBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    private lazy var bookmarkButton: UIButton = {
        let view = UIButton(type: .custom)
        view.backgroundColor = UIColor(r: 245, g: 245, b: 245)
        view.setImage(Asset.icBookmark.image, for: .normal)
        view.tintColor = .main1A
        view.addTarget(self, action: #selector(bookmarkButtonTapped), for: .touchUpInside)
        return view
    }()

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

    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 0, g: 0, b: 0, alpha: 0.1)
        view.layer.cornerRadius = 2
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

    private lazy var descriptionView: AnimeDetailsDescriptionView = {
        let view = AnimeDetailsDescriptionView()
        view.synopsisTapHandler = {
            self.presenter.presentSynopsisViewController()
        }
        return view
    }()

    private lazy var recommendationsView: RecommendationsView = {
        let view = RecommendationsView(presenter: presenter)
        return view
    }()

    private lazy var episodesView: AnimeDetailsEpisodesView = {
        let view = AnimeDetailsEpisodesView()
        view.tapHandler = {
            self.presenter.episodesButtonTapped()
        }
        return view
    }()

    private lazy var bottomBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .main2A
        return view
    }()

    // MARK: - Lifecycle

    init(presenter: AnimeDetailsPresenter) {
        self.presenter = presenter
        self.imageViewScale = presenter.state.imageViewScale
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        indicatorView.configureFrame { maker in
            maker.size(width: 35, height: 35)
                .center()
        }

        navigationBackgroundView.configureFrame { maker in
            maker.height(view.safeAreaInsets.top)
                .top().left().right()
        }

        bookmarkButton.configureFrame { maker in
            maker.size(width: 50, height: 50)
                .right(inset: 25)
                .bottom(to: view.nui_safeArea.bottom, inset: 10)
                .cornerRadius(25)
        }
        
        imageView.configureFrame { maker in
            maker.size(width: 190 * Layout.scaleFactorW / imageViewScale,
                       height: 250 * Layout.scaleFactorH / imageViewScale)
                .top(to: view.nui_safeArea.top)
                .centerX()
        }

        scrollView.configureFrame { maker in
            maker.top().left().right().bottom()
        }

        scrollView.contentInset = .init(top: 330 * Layout.scaleFactorH, left: 0, bottom: 0, right: 0)
        scrollView.contentSize = backdropView.bounds.size

        dividerView.configureFrame { maker in
            maker.size(width: 40, height: 3)
                .top(inset: 7)
                .centerX(to: backdropView.nui_centerX)
        }

        titleLabel.configureFrame { maker in
            maker.sizeToFit()
                .top(to: dividerView.nui_bottom, inset: 10)
                .left(inset: 30)
                .right(inset: 30)
        }

        descriptionView.configureFrame { maker in
            maker.height(205)
                .top(to: titleLabel.nui_bottom, inset: 7)
                .left()
                .right()
        }

        episodesView.configureFrame { maker in
            maker.height(50)
                .top(to: descriptionView.nui_bottom, inset: 15)
                .left()
                .right()
        }

        recommendationsView.configureFrame { maker in
            maker.height(200)
                .left()
                .right()
                .top(to: episodesView.nui_bottom, inset: 15)
        }

        bottomBackgroundView.configureFrame { maker in
            maker.height(view.safeAreaInsets.bottom)
                .bottom()
                .left()
                .right()
        }

        backdropView.configureFrame { maker in
            let height = recommendationsView.frame.origin.y + recommendationsView.frame.height + 500
            maker.height(height)
                .top().left().right()
        }
    }

    // MARK: - Actions

    @objc private func bookmarkButtonTapped() {
        presenter.addToFavorites()
    }

    @objc private func backButtonTapped() {
        presenter.backButtonTapped()
    }

    @objc private func handleGesture(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .right {
            presenter.backButtonTapped()
        }
    }

    // MARK: - Private

    private func setup() {
        view.backgroundColor = UIColor(r: 255, g: 255, b: 255, alpha: 0.8)
        addCustomBackButton()
        addSwipeGestureRecognizer()
        viewsIsHidden(isHidden: true)

        view.addSubview(indicatorView)
        view.addSubview(imageView)
        view.addSubview(scrollView)
        scrollView.addSubview(backdropView)
        backdropView.addSubview(dividerView)
        backdropView.addSubview(titleLabel)
        backdropView.addSubview(descriptionView)
        backdropView.addSubview(recommendationsView)
        backdropView.addSubview(episodesView)
        view.addSubview(bookmarkButton)
        view.addSubview(navigationBackgroundView)
        view.addSubview(bottomBackgroundView)

        scrollView.delegate = self
        presenter.viewDidLoad()

        bookmarkButton.accessibilityIdentifier = "bookmarkButton"
    }

    private func addCustomBackButton() {
        let backButton = UIBarButtonItem(image: Asset.icBack.image,
                                         style: .plain,
                                         target: self,
                                         action: #selector(backButtonTapped))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
    }

    private func addSwipeGestureRecognizer() {
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        gesture.direction = .right
        self.view.addGestureRecognizer(gesture)
    }

    private func viewsIsHidden(isHidden: Bool) {
        imageView.isHidden = isHidden
        scrollView.isHidden = isHidden
        bookmarkButton.isHidden = isHidden
        if isHidden {
            indicatorView.startAnimating()
        }
        else {
            indicatorView.stopAnimating()
        }
    }
}

// MARK: - TabBarViewInput

extension AnimeDetailsViewController: AnimeDetailsViewInput {

    func update(with state: AnimeDetailsState, force: Bool, animated: Bool) {
        imageView.image = state.image
        titleLabel.text = state.title
        descriptionView.ratingLabel.text = String(state.rating)
        descriptionView.genresLabel.text = state.genres
        descriptionView.synopsisLabel.text = state.synopsis
        episodesView.episodesCountLabel.text = "\(state.episodes) episodes"
        viewsIsHidden(isHidden: state.isViewsHidden)
        recommendationsView.collectionView.reloadData()

        imageViewScale = state.imageViewScale

        if state.isFavorite {
            bookmarkButton.tintColor = .main3A
        }
        else {
            bookmarkButton.tintColor = .main1A
        }

        if state.isNavigationBarHidden {
            navigationItem.title = ""
            navigationBackgroundView.backgroundColor = .clear
            titleLabel.alpha = 1
        }
        else {
            navigationItem.title = state.title
            navigationController?.navigationBar.setNeedsLayout()
            navigationBackgroundView.backgroundColor = .white
            titleLabel.alpha = 0
        }

        episodesView.openButton.isHidden = (state.episodes <= 1) ? true : false
        recommendationsView.isHidden = state.recommendationsModels.isEmpty
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
}

// MARK: - UIScrollViewDelegate

extension AnimeDetailsViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scale = abs(scrollView.contentInset.top / scrollView.contentOffset.y)
        presenter.updateImageViewScale(scale: scale)
        
        if scrollView.contentOffset.y > -view.safeAreaInsets.top {
            presenter.showNavigationBar(isHidden: false)
        }
        else {
            presenter.showNavigationBar(isHidden: true)
        }
    }
}

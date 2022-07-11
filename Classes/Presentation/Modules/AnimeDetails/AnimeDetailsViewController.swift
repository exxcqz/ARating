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

    private lazy var ratingLabel: UILabel = {
        let view = UILabel()
        view.font = .proDisplayBoldFont(ofSize: 15)
        view.textColor = .main1A
        view.textAlignment = .center
        return view
    }()

    private lazy var genresLabel: UILabel = {
        let view = UILabel()
        view.font = .proTextSemiboldFont(ofSize: 13)
        view.textColor = .main1A
        view.textAlignment = .center
        return view
    }()

    private lazy var synopsisLabel: UILabel = {
        let view = UILabel()
        view.font = .proDisplayRegularFont(ofSize: 18)
        view.numberOfLines = 0
        view.textColor = .main1A
        view.textAlignment = .left
        return view
    }()

    private lazy var synopsisButton: UIButton = {
        let view = UIButton(type: .custom)
        view.setTitle("Show all text", for: .normal)
        view.setTitleColor(.main3A, for: .normal)
        view.addTarget(self, action: #selector(synopsisButtonTapped), for: .touchUpInside)
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

        backdropView.configureFrame { maker in
            maker.height(1200)
                .top().left().right()
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

        ratingLabel.configureFrame { maker in
            maker.sizeToFit()
                .top(to: titleLabel.nui_bottom, inset: 7)
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
                .left(to: synopsisLabel.nui_left)
        }
    }

    // MARK: - Actions

    @objc private func bookmarkButtonTapped() {
        presenter.addToFavorites()
    }

    @objc private func synopsisButtonTapped() {
        presenter.presentSynopsisViewController()
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
        backdropView.addSubview(ratingLabel)
        backdropView.addSubview(genresLabel)
        backdropView.addSubview(synopsisLabel)
        backdropView.addSubview(synopsisButton)
        view.addSubview(bookmarkButton)
        view.addSubview(navigationBackgroundView)

        scrollView.delegate = self
        presenter.viewDidLoad()
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
        ratingLabel.text = String(state.rating)
        genresLabel.text = state.genres
        synopsisLabel.text = state.synopsis
        viewsIsHidden(isHidden: false)

        imageViewScale = state.imageViewScale

        if state.isFavorite {
            bookmarkButton.tintColor = .main3A
        }
        else {
            bookmarkButton.tintColor = .main1A
        }

        if state.isNavigationBarHidden {
            UIView.animate(withDuration: 0.3) {
                self.navigationItem.title = ""
                self.navigationBackgroundView.backgroundColor = .clear
                self.titleLabel.alpha = 1
            }
        }
        else {
            UIView.animate(withDuration: 0.3) {
                self.navigationItem.title = self.presenter.state.title
                self.navigationBackgroundView.backgroundColor = .white
                self.titleLabel.alpha = 0
            }
        }
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

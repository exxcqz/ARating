//
//  BookmarksViewController.swift
//  ARating
//
//  Created by Nikita Gavrikov on 07.07.2022.
//

import Foundation

import UIKit
import Framezilla

protocol BookmarksViewInput {
    func update(with state: BookmarksState, force: Bool, animated: Bool)
}

final class BookmarksViewController: UIViewController {
    var presenter: BookmarksPresenter

    // MARK: - Subviews

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(BookmarkViewCell.self, forCellWithReuseIdentifier: "cell")
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .clear
        return view
    }()

    // MARK: - Lifecycle

    init(presenter: BookmarksPresenter) {
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.configureFrame { maker in
            maker.top()
                .left()
                .right()
                .bottom()
        }

        collectionView.contentInset = .init(top: 0, left: 20, bottom: 0, right: 20)
    }

    // MARK: - Private

    private func setup() {
        view.backgroundColor = .main2A
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        presenter.viewDidLoad()
    }
}

// MARK: - MoviesViewInput

extension BookmarksViewController: BookmarksViewInput {

    func update(with state: BookmarksState, force: Bool, animated: Bool) {
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate

extension BookmarksViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.cellTappedEventTriggered(with: indexPath)
    }
}

// MARK: - UICollectionViewDataSource

extension BookmarksViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.state.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = presenter.state.items[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? BookmarkViewCell
        if model.image == nil {
            collectionView.reloadData()
        }
        cell?.imageView.image = model.image
        cell?.ratingLabel.text = String(model.rating)
        cell?.titleLabel.text = model.title.uppercased()
        if model.year == 0 {
            cell?.yearLabel.text = ""
        }
        else {
            cell?.yearLabel.text = String(model.year)
        }

        return cell ?? UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension BookmarksViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.bounds.width - 60) / 2
        return CGSize(width: width, height: 240 * Layout.scaleFactorH)
    }
}

// MARK: - UIScrollViewDelegate

extension BookmarksViewController: UIScrollViewDelegate {

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        collectionView.reloadData()
    }
}

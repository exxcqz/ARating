//
//  MoviesViewController.swift
//  ARating
//
//  Created by Nikita Gavrikov on 29.06.2022.
//

import UIKit
import Framezilla

protocol TopListViewInput {
    func update(with state: TopListState, force: Bool, animated: Bool)
}

final class TopListViewController: UIViewController {
    var presenter: TopListPresenter

    // MARK: - Subviews

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(TopListViewCell.self, forCellWithReuseIdentifier: "cell")
        view.backgroundColor = .clear
        return view
    }()

    // MARK: - Lifecycle

    init(presenter: TopListPresenter) {
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
        collectionView.configureFrame { maker in
            maker.top(inset: 148)
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
    }
}

// MARK: - MoviesViewInput

extension TopListViewController: TopListViewInput {

    func update(with state: TopListState, force: Bool, animated: Bool) {

    }
}

// MARK: - UICollectionViewDelegate

extension TopListViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(1)
    }
}

// MARK: - UICollectionViewDataSource

extension TopListViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.state.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = presenter.state.items[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TopListViewCell
        cell?.imageView.image = model.image
        cell?.titleLabel.text = model.title.uppercased()
        cell?.ratingLabel.text = String(model.rating)
        cell?.yearLabel.text = String(model.year)

        return cell ?? UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension TopListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.bounds.width - 60) / 2
        return CGSize(width: width, height: 240)
    }
}




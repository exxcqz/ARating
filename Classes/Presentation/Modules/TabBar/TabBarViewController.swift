//
//  MoviesViewController.swift
//  ARating
//
//  Created by Nikita Gavrikov on 29.06.2022.
//

import UIKit
import Framezilla

protocol TabBarViewInput {
    func update(with state: TabBarState, force: Bool, animated: Bool)
}

final class TabBarViewController: UIViewController {
    var presenter: TabBarPresenter

    // MARK: - Subviews

    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .blue
        return view
    }()

    // MARK: - Lifecycle

    init(presenter: TabBarPresenter) {
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
            maker.height(83)
                .left()
                .right()
                .bottom()
        }
    }

    // MARK: - Private

    private func setup() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - TabBarViewInput

extension TabBarViewController: TabBarViewInput {

    func update(with state: TabBarState, force: Bool, animated: Bool) {

    }
}

// MARK: - UICollectionViewDelegate

extension TabBarViewController: UICollectionViewDelegate {

}

// MARK: - UICollectionViewDataSource

extension TabBarViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

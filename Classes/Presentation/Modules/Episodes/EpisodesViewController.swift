//
//  EpisodesViewController.swift
//  ARating
//
//  Created by Nikita Gavrikov on 14.07.2022.
//

import UIKit

protocol EpisodesViewInput {
    func update(with state: EpisodesState, force: Bool, animated: Bool)
}

final class EpisodesViewController: UIViewController {
    var presenter: EpisodesPresenter

    // MARK: - Subviews

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 3
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(EpisodesViewCell.self, forCellWithReuseIdentifier: "cell")
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .clear
        return view
    }()

    // MARK: - Lifecycle

    init(presenter: EpisodesPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }

    private func setup() {
        view.backgroundColor = .main2A
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

// MARK: - EpisodesViewInput

extension EpisodesViewController: EpisodesViewInput {

    func update(with state: EpisodesState, force: Bool, animated: Bool) {
        navigationItem.title = state.title
        collectionView.reloadData()
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
}

// MARK: - UICollectionViewDataSource

extension EpisodesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.state.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? EpisodesViewCell
        let model = presenter.state.items[indexPath.row]
        cell?.titleLabel.text = "\(model.id). \(model.title ?? "")"
        cell?.scoreLabel.text = "Score: \(model.score ?? 0)"
        let fillerText: String = model.filler ? "Yes":"No"
        cell?.fillerLabel.text = "Filler: \(fillerText)"
        cell?.changeFillerLabel(with: model.filler)
        return cell ?? UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegate

extension EpisodesViewController: UICollectionViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offset > (contentHeight - scrollView.frame.height) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.presenter.fetchEpisodes()
            }
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension EpisodesViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: 60)
    }
}

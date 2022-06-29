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

    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(TabBarViewCell.self, forCellWithReuseIdentifier: "cell")
        view.backgroundColor = .clear
        return view
    }()

    var embeddedView: UIView? {
        didSet {
            oldValue?.removeFromSuperview()
            if let view = embeddedView {
                containerView.addSubview(view)
            }
        }
    }

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

        containerView.configureFrame { maker in
            maker.top()
                .left()
                .right()
                .bottom(to: collectionView.nui_top)
        }

        containerView.subviews.configureFrames { maker in
            maker.top().left().right().bottom()
        }
    }

    // MARK: - Private

    private func setup() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        view.addSubview(containerView)
        collectionView.delegate = self
        collectionView.dataSource = self
        presenter.viewDidLoad()
    }
}

// MARK: - TabBarViewInput

extension TabBarViewController: TabBarViewInput {

    func update(with state: TabBarState, force: Bool, animated: Bool) {
        embeddedView = state.embeddedView
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
}

// MARK: - UICollectionViewDelegate

extension TabBarViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectCell(with: indexPath)
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource

extension TabBarViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.state.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = presenter.state.items[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TabBarViewCell
        cell?.imageView.image = model.image
        cell?.titleLabel.text = model.title
        if indexPath.row == presenter.state.selectedCell {
            cell?.imageView.tintColor = .main3A
            cell?.titleLabel.textColor = .main3A
        }
        else {
            cell?.imageView.tintColor = .main4A
            cell?.titleLabel.textColor = .main4A
        }
        
        return cell ?? UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension TabBarViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.bounds.width / CGFloat(presenter.state.items.count)
        return CGSize(width: width, height: 60)
    }
}


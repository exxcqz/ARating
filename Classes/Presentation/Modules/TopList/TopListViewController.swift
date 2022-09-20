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

    private lazy var searchController: UISearchController = .init(searchResultsController: nil)

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(TopListViewCell.self, forCellWithReuseIdentifier: "cell")
        view.register(TopListIndicatorViewCell.self, forCellWithReuseIdentifier: "indicator")
        view.showsVerticalScrollIndicator = false
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

    deinit {
        print("deinit")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
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
        setupSearchController()
        setupNavigationBar()
        collectionView.dataSource = self
        collectionView.delegate = self
        presenter.fetchItems()

        collectionView.accessibilityIdentifier = "topListCollection"
    }

    private func setupSearchController() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        if presenter.state.searchModeActivated {
            searchController.searchBar.showsCancelButton = true
            navigationItem.title = presenter.state.query
        }
    }

    private func setupNavigationBar() {
        navigationItem.hidesBackButton = true
    }
}

// MARK: - MoviesViewInput

extension TopListViewController: TopListViewInput {

    func update(with state: TopListState, force: Bool, animated: Bool) {
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate

extension TopListViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.cellTappedEventTriggered(with: indexPath)
    }
}

// MARK: - UICollectionViewDataSource

extension TopListViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if presenter.state.items.count > 0 && presenter.state.currentPage < presenter.state.totalPage {
            return presenter.state.items.count + 1
        }
        return presenter.state.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row >= presenter.state.items.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "indicator", for: indexPath) as? TopListIndicatorViewCell
            cell?.indicatorView.startAnimating()
            return cell ?? UICollectionViewCell()
        }
        let model = presenter.state.items[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TopListViewCell
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

extension TopListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.bounds.width - 60) / 2
        return CGSize(width: width, height: 240 * Layout.scaleFactorH)
    }
}

// MARK: - UIScrollViewDelegate

extension TopListViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offset > (contentHeight - scrollView.frame.height - 100) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.presenter.fetchItems()
            }
        }
    }

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        collectionView.reloadData()
    }
}

// MARK: - UISearchBarDelegate

extension TopListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.searchButtonTapped(query: searchBar.text ?? "")
        searchBar.text = ""
        searchBar.endEditing(true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter.cancelButtonTapped()
    }
}

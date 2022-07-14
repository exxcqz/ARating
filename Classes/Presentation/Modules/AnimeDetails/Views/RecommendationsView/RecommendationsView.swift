//
//  RecommendationsView.swift
//  ARating
//
//  Created by Nikita Gavrikov on 12.07.2022.
//

import UIKit
import Framezilla

final class RecommendationsView: UIView {
    var presenter: AnimeDetailsPresenter

    // MARK: - Subviews

    private lazy var recommendationsLabel: UILabel = {
        let view = UILabel()
        view.font = .proDisplayBoldFont(ofSize: 20)
        view.text = L10n.Animedetails.Recommendations.title
        view.textColor = .main1A
        view.textAlignment = .left
        return view
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(RecommendationsViewCell.self, forCellWithReuseIdentifier: "cell")
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear
        return view
    }()

    init(presenter: AnimeDetailsPresenter) {
        self.presenter = presenter
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        recommendationsLabel.configureFrame { maker in
            maker.sizeToFit()
                .top(inset: 5)
                .left(inset: 30)
        }

        collectionView.configureFrame { maker in
            maker.top(to: recommendationsLabel.nui_bottom, inset: 7)
                .left()
                .right()
                .bottom()
        }

        collectionView.contentInset = .init(top: 0, left: 30, bottom: 0, right: 30)
    }

    // MARK: - Private

    private func setup() {
        addSubview(recommendationsLabel)
        addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

// MARK: - UICollectionViewDataSource

extension RecommendationsView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.state.recommendationsModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? RecommendationsViewCell
        let model = presenter.state.recommendationsModels[indexPath.row]
        if model.image == nil {
            collectionView.reloadData()
        }
        cell?.imageView.image = model.image
        return cell ?? UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegate

extension RecommendationsView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.cellTappedEventTriggered(with: indexPath)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension RecommendationsView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
    }
}


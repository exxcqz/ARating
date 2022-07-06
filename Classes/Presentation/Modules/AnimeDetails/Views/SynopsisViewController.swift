//
//  SynopsisDetailView.swift
//  ARating
//
//  Created by Nikita Gavrikov on 04.07.2022.
//

import UIKit

final class SynopsisViewController: UIViewController {

    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        return view
    }()

    private lazy var synopsisLabel: UILabel = {
        let view = UILabel()
        view.font = .proDisplayRegularFont(ofSize: 18)
        view.textColor = .main1A
        view.textAlignment = .left
        view.numberOfLines = 0
        return view
    }()

    init(synopsis: String) {
        super.init(nibName: nil, bundle: nil)
        setup()
        self.synopsisLabel.text = synopsis
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.configureFrame { maker in
            maker.top(to: view.nui_safeArea.top)
                .left()
                .right()
                .bottom()
        }

        synopsisLabel.configureFrame { maker in
            maker.heightToFit()
                .top()
                .left(inset: 30)
                .right(inset: 30)
        }

        scrollView.contentSize = synopsisLabel.bounds.size
    }

    private func setup() {
        view.backgroundColor = .main2A
        view.addSubview(scrollView)
        scrollView.addSubview(synopsisLabel)

        scrollView.delegate = self
        navigationItem.title = "Synopsis"
    }
}

// MARK: - UIScrollViewDelegate

extension SynopsisViewController: UIScrollViewDelegate {
    
}


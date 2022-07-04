//
//  SynopsisDetailView.swift
//  ARating
//
//  Created by Nikita Gavrikov on 04.07.2022.
//

import UIKit

final class SynopsisViewController: UIViewController {

    private lazy var synopsisTextView: UITextView = {
        let view = UITextView()
        view.isEditable = false
        view.isScrollEnabled = true
        view.font = .proDisplayRegularFont(ofSize: 18)
        view.textColor = .main1A
        view.textAlignment = .left
        return view
    }()

    init(synopsis: String) {
        super.init(nibName: nil, bundle: nil)
        setup()
        self.synopsisTextView.text = synopsis
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        synopsisTextView.configureFrame { maker in
            maker.heightToFit()
                .top(to: view.nui_safeArea.top, inset: 10)
                .left(inset: 30)
                .right(inset: 30)
        }
    }

    private func setup() {
        view.backgroundColor = .main2A
        view.addSubview(synopsisTextView)
        navigationItem.title = "Synopsis"
    }
}


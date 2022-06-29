//
//  MoviesViewController.swift
//  ARating
//
//  Created by Nikita Gavrikov on 29.06.2022.
//

import UIKit

protocol MoviesViewInput {
    func update(with state: MoviesState, force: Bool, animated: Bool)
}

final class MoviesViewController: UIViewController {
    var presenter: MoviesPresenter

    init(presenter: MoviesPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}

// MARK: - MoviesViewInput

extension MoviesViewController: MoviesViewInput {

    func update(with state: MoviesState, force: Bool, animated: Bool) {

    }
}

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

final class TabBarController: UITabBarController {
    var presenter: TabBarPresenter


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

    private func setup() {
        viewControllers = presenter.state.viewControllers
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        delegate = self
    }
}

// MARK: - UITabBarControllerDelegate

extension TabBarController: UITabBarControllerDelegate {

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        presenter.didSelect(index: item.tag)
    }
}

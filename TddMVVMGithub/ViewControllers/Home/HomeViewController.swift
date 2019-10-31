//
//  HomeViewController.swift
//  TddMVVMGithub
//
//  Created by tskim on 2019/10/30.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UITabBarController, HasDisposeBag {
    
    struct Dependency {
        let viewModel: NextPageViewModel
    }
    
    private let uiSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.returnKeyType = .done
        searchBar.placeholder = L10n.searchbarPlaceholder
        return searchBar
    }()

    private let dependency: Dependency

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(dependency: Dependency) {
        defer { initViews() }
        self.dependency = dependency
        super.init(nibName: nil, bundle: nil)
    }

    private func initViews() {
        navigationItem.titleView = uiSearchBar
        setupChildViewControllers()
        bindingViews()
    }
    private func setupChildViewControllers() {
        let firstViewController = GithubSearchViewController(viewModel: dependency.viewModel).then {
            $0.tabBarItem = UITabBarItem(title: L10n.tabbarSearchTitle, image: Asset.icSearchBlack24pt.image, tag: 0)
        }

        let secondViewController = GithubSearchViewController(viewModel: dependency.viewModel).then {
            $0.tabBarItem = UITabBarItem(title: L10n.tabbarFavoriteTitle, image: Asset.icFavoriteBlack24pt.image, tag: 1)
        }

        self.viewControllers = [
            firstViewController,
            secondViewController
        ]
    }

    private func bindingViews() {
        uiSearchBar.rx.text.orEmpty
            .distinctUntilChanged()
            .bind(to: self.dependency.viewModel.searchText)
            .disposed(by: disposeBag)

        uiSearchBar.rx.searchButtonClicked
            .do(onNext: { [weak uiSearchBar] in
                uiSearchBar?.resignFirstResponder()
            })
            .bind(to: self.dependency.viewModel.doSearch)
            .disposed(by: disposeBag)
    }
}

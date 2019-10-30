//
//  HomeViewController.swift
//  TddMVVMGithub
//
//  Created by tskim on 2019/10/30.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UITabBarController {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(dependency: Dependency) {
        super.init(nibName: nil, bundle: nil)
        setupChildViewControllers(dependency: dependency)
    }
    private func setupChildViewControllers(dependency: Dependency) {
        
        let firstViewController = GithubSearchViewController(viewModel: dependency.getViewModel())
        firstViewController.title = "Search"
        
        self.viewControllers = [
            GithubSearchViewController(viewModel: dependency.getViewModel()),
            GithubSearchViewController(viewModel: dependency.getViewModel())
        ]
    }
}

extension HomeViewController {
    struct Dependency {
        let viewModel: () -> SearchViewModel
        
        init(viewModel: @escaping () -> SearchViewModel) {
            self.viewModel = viewModel
        }
        func getViewModel() -> SearchViewModel {
            return viewModel()
        }
    }
}

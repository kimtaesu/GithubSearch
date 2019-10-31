//
//  ViewController.swift
//  TddMVVMGithub
//
//  Created by tskim on 10/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import RxDataSources
import UIKit

class GithubSearchViewController: UIViewController, HasDisposeBag {

    private let viewModel: SearchUserViewModel
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    let dataSource = RxCollectionViewSectionedAnimatedDataSource<GitUserSection>(
        configureCell: { ds, cv, ip, item in
            guard let cell = cv.dequeueReusableCell(withReuseIdentifier: GitUserCell.swiftIdentifier, for: ip) as? GitUserCell else { return UICollectionViewCell() }
            cell.userName.text = item.login
            cell.score.text = String(item.score)
            return cell
        }
    )

    init(viewModel: SearchUserViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.do {
            $0.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            $0.isHidden = true
        }
        collectionView.do {
            $0.register(GitUserCell.nib, forCellWithReuseIdentifier: GitUserCell.swiftIdentifier)
            $0.rx.setDelegate(self).disposed(by: disposeBag)
        }
        bindingViews()
    }
    private func bindingViews() {
        viewModel.isLoading
            .distinctUntilChanged()
            .debug("isLoading")
            .bind(to: activityIndicator.rx.showLoading)
            .disposed(by: disposeBag)

        viewModel.sections
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        viewModel.showAlert
            .bind(to: self.rx.showAlertView)
            .disposed(by: disposeBag)
    }
}

extension GithubSearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let collectionViewLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize(width: 0, height: 0) }
        let sectionInset = collectionViewLayout.sectionInset
        let contentWidth = collectionView.safeAreaLayoutGuide.layoutFrame.width
            - sectionInset.left
            - sectionInset.right
            - collectionView.contentInset.left
            - collectionView.contentInset.right

        return CGSize(width: contentWidth, height: 130)
    }
}

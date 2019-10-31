//
//  ViewController.swift
//  TddMVVMGithub
//
//  Created by tskim on 10/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import RxDataSources
import RxSwift
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
            cell.avatar.beautiful.setImage(with: URL(string: item.avatar_url))
            return cell
        }
    )

    let emptyLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorName.emptyLabel
        label.setTextSize(18)
        label.textAlignment = .center
        return label
    }()

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
            $0.backgroundView = emptyLabel
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

        viewModel.navigateDetailView
            .asDriver(onErrorJustReturn: GitUser.empty)
            .drive(onNext: { [weak self] user in
                guard let self = self else { return }
                let detailViewController = DetailViewController(user: user)
                self.present(detailViewController, animated: true)
            })
            .disposed(by: disposeBag)

        viewModel.emptyMessage
            .debug("emptyMessage")
            .bind(to: self.collectionView.rx.setEmptyView(view: emptyLabel))
            .disposed(by: disposeBag)

        collectionView.rx.itemSelected
            .bind(to: viewModel.itemSelected)
            .disposed(by: disposeBag)

        //        collectionView.rx.reachedBottom
//            .withLatestFrom(nextpageViewModel.isLoading)
//            .filter { !$0 }
//            .bind(to: nextpageViewModel.nextPage)
//            .bind(to: nextpageViewModel.nextPage)
//            .disposed(by: disposeBag)
//            .debounce(0.2, scheduler: MainScheduler.asyncInstance)
//            .bind(to: viewModel.nextPage)
//            .disposed(by: disposeBag)
    }
}

extension GithubSearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // TODO: cancel image download
    }
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

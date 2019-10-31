//
//  NextPageViewModel.swift
//  TddMVVMGithub
//
//  Created by tskim on 2019/10/31.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class NextPageViewModel: HasDisposeBag {

    private let service: GithubServiceType
    private let scheduler: RxSchedulerType

    let isLoading = PublishRelay<Bool>()
    let isNextLoading = PublishRelay<Bool>()
    let searchText = PublishRelay<String>()
    let sections = PublishRelay<[GitUserSection]>()
    let doSearch = PublishRelay<Void>()
    let nextPage = PublishRelay<Void>()
    let showAlert = PublishRelay<UIAlertViewModel>()
    private var _userSections: [GitUserSection] = []

    init(of: GithubServiceType, scheduler: RxSchedulerType) {
        service = of
        self.scheduler = scheduler

        let shareSearchText = searchText.share()

        doSearch
            .debug("doSearch")
            .observeOn(self.scheduler.main)
            .do(onNext: { [weak isLoading] _ in
                assertMainThread()
                isLoading?.accept(true)
            })
            .observeOn(self.scheduler.io)
            .withLatestFrom(shareSearchText)
            .flatMapLatest { [service] text -> Observable<GitUserResponse> in
                assertBackgroundThread()
                return service.searchUser(sortOption: SearchOption(query: text, sort: "followers"))
                    .debug("search a repositories of Github")
                    .do(onError: { [weak self] e in
                        guard let self = self else { return }
                        logger.error(e)
                        self.showAlert.accept(UIAlertViewModel.Builder(message: "에러가 발생하였습니다.").build())
                    })
                    .catchError {
                        logger.error("error: \($0)")
                        return Observable.just(GitUserResponse(total_count: Int.max, incomplete_results: false, items: []))
                }
            }
            .subscribe(onNext: { [weak self] result in
                guard let self = self else { return }
                logger.info("subscribe: \(result)")
                self.isLoading.accept(false)
                if !result.items.isEmpty {
                    self._userSections = [GitUserSection(header: "users", items: result.items)]
                    self.sections.accept(self._userSections)
                }
            })
            .disposed(by: disposeBag)
    }
}

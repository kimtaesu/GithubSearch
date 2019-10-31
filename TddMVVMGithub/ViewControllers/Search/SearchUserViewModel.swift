//
//  GithubViewModel.swift
//  TddMVVMGithub
//
//  Created by tskim on 11/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class SearchUserViewModel: HasDisposeBag {

    private let service: GithubServiceType
    private let scheduler: RxSchedulerType

    let searchText = PublishRelay<String>()
    let itemSelected = PublishRelay<IndexPath>()
    let doSearch = PublishRelay<Void>()

    let isLoading = PublishRelay<Bool>()
    let emptyMessage = BehaviorRelay<String>(value: L10n.searchEmptyMessage)
    let showAlert = PublishRelay<UIAlertViewModel>()
    let sections = PublishRelay<[GitUserSection]>()
    let navigateDetailView = PublishRelay<String>()
    
    private var _userSections: [GitUserSection] = []
    
    init(of: GithubServiceType, scheduler: RxSchedulerType) {
        service = of
        self.scheduler = scheduler

        let shareSearchText = searchText.share()
        self.emptyMessage.accept(L10n.searchEmptyMessage)
        itemSelected
            .debug("item selected")
            .subscribe(onNext: { [weak self] ip in
                guard let self = self else { return }
                let url = self._userSections[ip.section].items[ip.item].url
                self.navigateDetailView.accept(url)
            })
            .disposed(by: disposeBag)
        
        doSearch
            .debug("doSearch")
            .observeOn(self.scheduler.main)
            .do(onNext: { [weak isLoading] _ in
                    assertMainThread()
                    isLoading?.accept(true)
                    self.emptyMessage.accept("")
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
                    self.emptyMessage.accept("")
                }
            })
            .disposed(by: disposeBag)
    }

}

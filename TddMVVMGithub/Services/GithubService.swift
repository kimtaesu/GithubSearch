//
//  GithubService.swift
//  TddMVVMGithub
//
//  Created by tskim on 10/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import RxSwift

class GithubService: GithubServiceType {

    static let BASE_URL = "https://api.github.com/"
    let timeoutInterval = 5.0
    private let requests: NetworkRequestProtocol
    private let scheduler: RxSchedulerType

    init(
        scheduler: RxSchedulerType,
        requests: NetworkRequestProtocol
    ) {
        self.requests = requests
        self.scheduler = scheduler
    }

    convenience init(scheduler: RxSchedulerType) {
        self.init(scheduler: scheduler, requests: Requests.shared)
    }

    func searchUser(sortOption: SearchOption) -> Observable<GitUserResponse> {
        let path = "/search/users"
        do {
            return search(request: try makeURLRequest(path: path, sortOption: sortOption))
        } catch {
            return Observable.error(error)
        }
    }
    private func makeURLRequest(path: String, sortOption: SearchOption) throws -> URLRequest {
        var request = try URLRequestBuilder
            .get(baseUrl: GithubService.BASE_URL)
            .path(path)
            .queryItems(sortOption.tryQueryItem())
            .build()
        request.addValue("", forHTTPHeaderField: "User-Agent")
        return request
    }
    private func search<T>(request: URLRequest) -> Observable<T> where T: Decodable {
        return self.requests.request(with: request)
            .map(T.self)
            .subscribeOn(self.scheduler.network)
    }
}

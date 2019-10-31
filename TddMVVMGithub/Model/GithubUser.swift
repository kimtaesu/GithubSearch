//
//  GithubUser.swift
//  TddMVVMGithub
//
//  Created by tskim on 2019/10/30.
//  Copyright © 2019 hucet. All rights reserved.
//

import RxDataSources

struct GitUserResponse: Decodable, Equatable {
    let total_count: Int
    let incomplete_results: Bool
    let items: [GitUser]
}

struct GitUser: Decodable, Equatable {
    let login: String
    let id: Int
    let avatar_url: String
    let url: String
    let html_url: String
    let score: Double
}

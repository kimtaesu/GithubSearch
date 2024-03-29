//
//  SearchRepositories+Equatable.swift
//  TddMVVMGithubTests
//
//  Created by tskim on 10/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
@testable import TddMVVMGithub

extension GitUserResponse: Equatable {
    public static func == (lhs: GitUserResponse, rhs: GitUserResponse) -> Bool {
        return lhs.total_count == rhs.total_count && lhs.items == rhs.items
    }
}

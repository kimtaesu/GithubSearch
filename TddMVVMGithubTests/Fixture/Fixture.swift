//
//  Fixture.swift
//  TddMVVMGithubTests
//
//  Created by tskim on 10/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
@testable import TddMVVMGithub

struct Fixture {
    struct GitUser {
        static let sample: GitUserResponse = ResourcesLoader.loadJson("user_sample")
        static var first: TddMVVMGithub.GitUser {
            return sample.items.first!
        }
        static let sampleData: Data = ResourcesLoader.readData("user_sample", ofType: "json")
    }
}

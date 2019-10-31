//
//  RepositoryDecodeTest.swift
//  TddMVVMGithubTests
//
//  Created by tskim on 10/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import XCTest
@testable import TddMVVMGithub

class SearchRepositoriesDecodeTest: XCTestCase {

    func testDecode() {
        let sample = Fixture.GitUser.sampleData
        var result: GitUserResponse?
        do {
            result = try JSONDecoder().decode(GitUserResponse.self, from: sample)
        } catch {
            print("\(#function) \(#line) : catchs \(error)")
        }
        XCTAssertNotNil(result)
    }
}

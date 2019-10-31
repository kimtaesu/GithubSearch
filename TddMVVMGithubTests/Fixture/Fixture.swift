//
//  Fixture.swift
//  TddMVVMGithubTests
//
//  Created by tskim on 10/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import CoreData
import Then
@testable import TddMVVMGithub

struct Fixture {
    struct GitUser {
        static let sample: GitUserResponse = ResourcesLoader.loadJson("user_sample")
        static var first: TddMVVMGithub.GitUser {
            return sample.items.first!
        }
        static let sampleData: Data = ResourcesLoader.readData("user_sample", ofType: "json")
    }
    
    struct FXRFavorite {
        static func createFavorite(context: NSManagedObjectContext, id: Int64 = 1) -> Favorite {
            return Favorite(context: context).then {
                $0.id = id
            }
        }
    }
}

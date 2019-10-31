//
//  FavoriteServiceType.swift
//  TddMVVMGithub
//
//  Created by tskim on 2019/10/31.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import RxSwift

protocol FavoriteServiceType: class {
    func addFavorite(favorite: Favorite)
    func removeFavorite(favorite: Favorite)
    func isFavorite(id: Int)
}

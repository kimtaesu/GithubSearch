//
//  FavoriteServiceType.swift
//  TddMVVMGithub
//
//  Created by tskim on 2019/10/31.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import RxSwift
import CoreData

protocol FavoriteServiceType: class {
    func isFavorite(context: NSManagedObjectContext, id: Int) -> Observable<Bool>
    func getFavorite(context: NSManagedObjectContext) -> Observable<[Favorite]>
}

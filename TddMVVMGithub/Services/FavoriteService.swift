//
//  FavoriteService.swift
//  TddMVVMGithub
//
//  Created by tskim on 2019/10/31.
//  Copyright © 2019 hucet. All rights reserved.
//

import CoreData
import Foundation
import RxSwift

class FavoriteService: FavoriteServiceType {
    func isFavorite(context: NSManagedObjectContext, id: Int) -> Observable<Bool> {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Favorite.fetchRequest().then {
            $0.fetchLimit = 1
            $0.predicate = NSPredicate(format: "id == %d", id)
        }
        return fetch(
            context: context,
            request: fetchRequest,
            creator: {
                !$0.isEmpty
            })
    }

    func getFavorite(context: NSManagedObjectContext) -> Observable<[Favorite]> {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Favorite.fetchRequest()
        return fetch(
            context: context,
            request: fetchRequest,
            creator: {
                $0 as? [Favorite] ?? []
            })
    }
    private func fetch<T>(
        context: NSManagedObjectContext,
        request: NSFetchRequest<NSFetchRequestResult>,
        creator: @escaping ([Any]) -> T
    ) -> Observable<T> {
        return Observable.create { observer in
            assertBackgroundThread()
            do {
                let result = try context.fetch(request)
                let fetchResult = creator(result)
                observer.onNext(fetchResult)
                observer.onCompleted()
            } catch let error as NSError {
                logger.info("Could not fetch. \(error), \(error.userInfo)")
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
}

//
//  CoreDataManager+Flush.swift
//  TddMVVMGithubTests
//
//  Created by tskim on 2019/10/31.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import CoreData
@testable import TddMVVMGithub

extension CoreDataManager {
  func flushData() {
    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Favorite.fetchRequest()
    let objs = try! context.fetch(fetchRequest)
    for case let obj as NSManagedObject in objs {
      context.delete(obj)
    }
    try! context.save()
  }
}

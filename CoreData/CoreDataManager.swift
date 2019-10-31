//
//  CoreDataManager.swift
//  TddMVVMGithub
//
//  Created by tskim on 2019/10/31.
//  Copyright © 2019 hucet. All rights reserved.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TddMVVMGithub")
        container.loadPersistentStores(completionHandler: { storeDescription, error in
            if let error = error as NSError? {
                logger.error("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                logger.error("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension CoreDataManager {
    var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
}

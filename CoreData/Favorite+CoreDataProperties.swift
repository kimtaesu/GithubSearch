//
//  Favorite+CoreDataProperties.swift
//  
//
//  Created by tskim on 2019/10/31.
//
//

import Foundation
import CoreData


extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var id: Int64
    @NSManaged public var url: String?
    @NSManaged public var userName: String?

}

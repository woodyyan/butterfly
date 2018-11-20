//
//  FavEntity+CoreDataProperties.swift
//  
//
//  Created by Songbai Yan  on 2018/11/20.
//
//

import Foundation
import CoreData

extension FavEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavEntity> {
        return NSFetchRequest<FavEntity>(entityName: "FavEntity")
    }

    @NSManaged public var picture: String?
    @NSManaged public var name: String?
    @NSManaged public var butterflyId: Int32
    @NSManaged public var createdDate: NSDate?
}

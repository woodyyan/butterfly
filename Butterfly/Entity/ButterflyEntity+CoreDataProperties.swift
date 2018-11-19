//
//  ButterflyEntity+CoreDataProperties.swift
//  
//
//  Created by Songbai Yan  on 2018/11/19.
//
//

import Foundation
import CoreData

extension ButterflyEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ButterflyEntity> {
        return NSFetchRequest<ButterflyEntity>(entityName: "ButterflyEntity")
    }

    @NSManaged public var id: Int32
    @NSManaged public var butterflyId: Int32
    @NSManaged public var setId: Int32
    @NSManaged public var name: String?
    @NSManaged public var pictures: String?
    @NSManaged public var createdDate: NSDate?
    @NSManaged public var updatedDate: NSDate?
}

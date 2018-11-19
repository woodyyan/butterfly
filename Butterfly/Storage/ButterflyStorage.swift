//
//  ButterflyStorage.swift
//  Butterfly
//
//  Created by Songbai Yan  on 2018/11/19.
//  Copyright © 2018 Songbai Yan . All rights reserved.
//

import Foundation
import CoreData

class ButterflyStorage {
    private var context: NSManagedObjectContext!
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func save(butterfly: Butterfly) {
        let entity = NSEntityDescription.insertNewObject(forEntityName: "ButterflyEntity", into: context) as! ButterflyEntity
        entity.id = Int32(butterfly.id)
        entity.butterflyId = Int32(butterfly.butterflyId)
        entity.name = butterfly.name
        entity.setId = Int32(butterfly.setId)
        entity.pictures = butterfly.pictures.map { String($0) }.joined(separator: ",")
        entity.createdDate = butterfly.createdDate
        entity.updatedDate = butterfly.updatedDate
        context.saveIfNeeded()
    }
    
    func fetch() -> [Butterfly] {
        var butterflies = [Butterfly]()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ButterflyEntity")
        do {
            if let results = try self.context.fetch(request) as? [ButterflyEntity] {
                if !results.isEmpty {
                    for result in results {
                        butterflies.append(result.toButterfly())
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return butterflies
    }
}

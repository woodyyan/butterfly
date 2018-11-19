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
    private let defaultSize = 20
    private var context: NSManagedObjectContext!
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func save(butterfly: Butterfly) -> Bool {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ButterflyEntity")
        let predicate = NSPredicate(format: "%K == %@", "id", NSNumber(value: Int32(butterfly.id)))
        request.predicate = predicate
        if let count = try? context.count(for: request) {
            // swiftlint:disable empty_count
            if count == 0 {
                let entity = NSEntityDescription.insertNewObject(forEntityName: "ButterflyEntity", into: context) as! ButterflyEntity
                entity.id = Int32(butterfly.id)
                entity.butterflyId = Int32(butterfly.butterflyId)
                entity.name = butterfly.name
                entity.setId = Int32(butterfly.setId)
                entity.pictures = butterfly.pictures.map { String($0) }.joined(separator: ",")
                entity.createdDate = butterfly.createdDate
                entity.updatedDate = butterfly.updatedDate
                context.saveIfNeeded()
                return true
            }
        }
        return false
    }
    
    func fetch(page: Int) -> [Butterfly] {
        var butterflies = [Butterfly]()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ButterflyEntity")
        request.fetchLimit = defaultSize
        request.fetchOffset = page
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

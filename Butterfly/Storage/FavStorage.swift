//
//  FavStorage.swift
//  Butterfly
//
//  Created by Songbai Yan  on 2018/11/20.
//  Copyright © 2018 Songbai Yan . All rights reserved.
//

import Foundation
import CoreData

class FavStorage {
    private let defaultSize = 30
    
    private var context: NSManagedObjectContext!
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func exists(_ picture: String) -> Bool {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavEntity")
        let predicate = NSPredicate(format: "%K == %@", "picture", picture)
        request.predicate = predicate
        if let count = try? context.count(for: request) {
            // swiftlint:disable empty_count
            return count > 0
        }
        return false
    }
    
    func save(butterflyId: Int, name: String, picture: String) -> Bool {
        if !self.exists(picture) {
            let entity = NSEntityDescription.insertNewObject(forEntityName: "FavEntity", into: context) as! FavEntity
            entity.butterflyId = Int32(butterflyId)
            entity.name = name
            entity.picture = picture
            entity.createdDate = Date()
            return context.saveIfNeeded()
        }
        return false
    }
    
    func fetch(page: Int) -> [FavEntity] {
        var favs = [FavEntity]()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavEntity")
        request.fetchLimit = defaultSize
        request.fetchOffset = page
        let sort = NSSortDescriptor(key: "createdDate", ascending: false)
        request.sortDescriptors = [sort]
        do {
            if let results = try self.context.fetch(request) as? [FavEntity] {
                if !results.isEmpty {
                    for result in results {
                        favs.append(result)
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return favs
    }
}

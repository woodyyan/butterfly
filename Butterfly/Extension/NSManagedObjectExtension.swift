//
//  NSManagedObjectExtension.swift
//  Butterfly
//
//  Created by Songbai Yan  on 2018/11/19.
//  Copyright © 2018 Songbai Yan . All rights reserved.
//

import Foundation
import CoreData

extension ButterflyEntity {
    func toButterfly() -> Butterfly {
        var butterfly = Butterfly()
        butterfly.id = Int(self.id)
        butterfly.butterflyId = Int(self.butterflyId)
        butterfly.setId = Int(self.setId)
        butterfly.name = self.name!
        butterfly.createdDate = self.createdDate!
        butterfly.updatedDate = self.updatedDate!
        butterfly.pictures = self.pictures!.split(separator: ",").map({ (sub) -> String in
            return String(sub)
        })
        return butterfly
    }
}

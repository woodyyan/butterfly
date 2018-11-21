//
//  File.swift
//  Butterfly
//
//  Created by Songbai Yan  on 2018/11/9.
//  Copyright © 2018 Songbai Yan . All rights reserved.
//

import Foundation

class PictureViewModel: BaseViewModel {
    let freePicCount = 3
    var butterfly: Butterfly!
    var currentSelected = 0
    var isFromFav = false
    
    private var storage: FavStorage!
    
    init(storage: FavStorage) {
        super.init()
        
        self.storage = storage
    }
    
    func addFav(picture: String) -> Bool {
        return storage.save(butterflyId: butterfly.butterflyId, name: butterfly.name, picture: picture)
    }
    
    func removeFav(picture: String) -> Bool {
        return storage.delete(picture: picture)
    }
    
    func favExists(_ index: Int) -> Bool {
        return storage.exists(self.butterfly.pictures[index])
    }
}

//
//  FavViewModel.swift
//  Butterfly
//
//  Created by Songbai Yan  on 2018/11/20.
//  Copyright © 2018 Songbai Yan . All rights reserved.
//

import Foundation

class FavViewModel: BaseViewModel {
    private var storage: FavStorage!
    private var nextPage = 0
    
    var favs = [FavEntity]()
    
    init(storage: FavStorage) {
        super.init()
        
        self.storage = storage
        
        fetch()
    }
    
    private func fetch() {
        favs = storage.fetch(page: nextPage)
        nextPage += 1
    }
}

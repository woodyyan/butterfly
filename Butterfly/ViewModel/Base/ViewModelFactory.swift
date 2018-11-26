//
//  ViewModelFactory.swift
//  Butterfly
//
//  Created by Songbai Yan  on 2018/11/8.
//  Copyright © 2018 Songbai Yan . All rights reserved.
//

import Foundation

class ViewModelFactory {
    private static var single: ViewModelFactory!
    
    static var shared: ViewModelFactory {
        if single == nil {
            single = ViewModelFactory()
        }
        return single
    }
    
    private var viewModels = [BaseViewModel]()
    
    private init() {
        let context = CoreStorage.shared.persistentContainer.viewContext
        let butterflyStorage = ButterflyStorage(context: context)
        let favStorage = FavStorage(context: context)
        let service = ButterflyService()
        viewModels.append(HomeViewModel(storage: butterflyStorage, service: service))
        viewModels.append(SettingsViewModel(storage: favStorage))
        viewModels.append(PictureViewModel(storage: favStorage))
        viewModels.append(FavViewModel(storage: favStorage))
    }
    
    func create<T>() -> T {
        let viewModel: T = viewModels.first { (vm) -> Bool in
            return vm is T
            } as! T
        return viewModel
    }
}

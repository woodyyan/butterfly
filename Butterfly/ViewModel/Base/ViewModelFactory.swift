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
//        let context = CoreStorage.shared.persistentContainer.viewContext
//        let tagStorage = TagStorage(context: context)
        viewModels.append(SettingsViewModel())
        viewModels.append(HomeViewModel())
    }
    
    func create<T>() -> T {
        let viewModel: T = viewModels.first { (vm) -> Bool in
            return vm is T
            } as! T
        return viewModel
    }
}

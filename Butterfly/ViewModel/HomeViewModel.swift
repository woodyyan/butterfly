//
//  HomeViewModel.swift
//  Butterfly
//
//  Created by Songbai Yan  on 2018/11/9.
//  Copyright © 2018 Songbai Yan . All rights reserved.
//

import Foundation
import Moya
import ObjectMapper

class HomeViewModel: BaseViewModel {
    private var storage: ButterflyStorage!
    private var service: ButterflyService!
    
    var delegate: FetchButterflyDelegate?
    var butterflySections = [ButterflySection]()
    
    init(storage: ButterflyStorage, service: ButterflyService) {
        super.init()
        
        self.storage = storage
        self.service = service
        
        fetchFromServer()
        fetchFromLocal()
    }
    
    private func fetchFromLocal() {
        let butterflies = storage.fetch(page: 0)
        let dic = Dictionary(grouping: butterflies, by: { $0.createdDate.toTitleString() })
        self.butterflySections = dic.map { (arg) -> ButterflySection in
            let (key, value) = arg
            return ButterflySection(title: key, butterflies: value)
        }
    }
    
    func fetchFromServer() {
        service.fetchNewButterflies { (success) in
            if success {
                self.fetchFromLocal()
            }
            self.delegate?.fetchButterfly(viewModel: self, success: success)
        }
    }
        
//        for _ in 0...1 {
//            var dailySet = ButterflyData(date: "today")
//            for _ in 0...2 {
//                var butterfly = Butterfly()
//                butterfly
//                butterfly.pictures.append("2")
//                butterfly.pictures.append("7")
//                butterfly.pictures.append("1")
//                butterfly.pictures.append("7")
//                butterfly.pictures.append("2")
//                butterfly.pictures.append("7")
//                butterfly.pictures.append("1")
//                butterfly.pictures.append("2")
//                butterfly.pictures.append("1")
//                dailySet.butterflies.append(butterfly)
//            }
//            butterflySets.append(dailySet)
//        }
}

protocol FetchButterflyDelegate: NSObjectProtocol {
    func fetchButterfly(viewModel: HomeViewModel, success: Bool)
}

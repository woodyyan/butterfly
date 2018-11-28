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
    
    weak var delegate: FetchButterflyDelegate?
    var butterflySections = [ButterflySection]()
    
    init(storage: ButterflyStorage, service: ButterflyService) {
        super.init()
        
        self.storage = storage
        self.service = service
        
        fetchNewFromServer()
        fetchFromLocal()
    }
    
    private func fetchFromLocal() {
        let butterflies = storage.fetch()
        let dic = Dictionary(grouping: butterflies, by: { $0.createdDate.toOrderNumber() })

        self.butterflySections = dic.sorted { $0.key > $1.key }.map { (arg) -> ButterflySection in
            let (_, value) = arg
            return ButterflySection(title: value.first!.createdDate.toTitleString(), butterflies: value)
        }
    }
    
    func fetchNewFromServer() {
        fetchFromServer(page: 0, isPullRefresh: true)
    }
    
    func fetchMoreFromServer() {
        let butterflies = self.butterflySections.flatMap { (section) -> [Butterfly] in
            return section.butterflies
        }
        fetchFromServer(page: butterflies.count/20, isPullRefresh: false)
    }
    
    private func fetchFromServer(page: Int, isPullRefresh: Bool) {
        service.fetchNewButterflies(page: page) { (success) in
            if success {
                self.fetchFromLocal()
            }
            self.delegate?.fetchButterfly(viewModel: self, success: success, isPullRefresh: isPullRefresh)
        }
    }
}

protocol FetchButterflyDelegate: NSObjectProtocol {
    func fetchButterfly(viewModel: HomeViewModel, success: Bool, isPullRefresh: Bool)
}

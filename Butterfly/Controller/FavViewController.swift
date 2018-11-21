//
//  FavViewController.swift
//  Butterfly
//
//  Created by Songbai Yan  on 2018/11/10.
//  Copyright © 2018 Songbai Yan . All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class FavViewController: UICollectionViewController {
    private let viewModel: FavViewModel = ViewModelFactory.shared.create()
    
    private let defaultRowNumber = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
    }

    init() {
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: Configs.imageWidth, height: Configs.imageHeight)
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 14, bottom: 10, right: 14)
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initUI() {
        self.title = "收藏"
        self.collectionView.backgroundColor = UIColor.background
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
}

extension FavViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return defaultRowNumber
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.favs.count/3 + 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let index = indexPath.section*defaultRowNumber+indexPath.row
        if index < viewModel.favs.count {
            let fav = viewModel.favs[index]
            let image = ImageCache.default.retrieveImageInDiskCache(forKey: fav.picture!)
            let imageView = UIImageView(image: image)
            imageView.layer.cornerRadius = Configs.cornerRadius
            imageView.layer.masksToBounds = true
            imageView.frame = CGRect(x: 0, y: 0, width: Configs.imageWidth, height: Configs.imageHeight)
            cell.addSubview(imageView)
        }
        return cell
    }
}

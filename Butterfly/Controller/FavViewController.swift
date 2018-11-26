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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetch()
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
        let favCount = viewModel.favs.count
        if favCount == 0 {
            return 0
        }
        if section < getSectionNumber(favCount: favCount) - 1 {
            return defaultRowNumber
        } else if favCount%defaultRowNumber == 0 {
            return defaultRowNumber
        }
        return favCount%defaultRowNumber
    }
    
    private func getSectionNumber(favCount: Int) -> Int {
        if favCount % defaultRowNumber == 0 {
            return favCount/defaultRowNumber
        } else {
            return favCount/defaultRowNumber + 1
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return getSectionNumber(favCount: self.viewModel.favs.count)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let index = indexPath.section*defaultRowNumber+indexPath.row
        if index < viewModel.favs.count {
//            cell.subviews.forEach { (view) in
//                view.removeFromSuperview()
//            }
            let fav = viewModel.favs[index]
            let image = ImageCache.default.retrieveImageInDiskCache(forKey: fav.picture!)
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFill
            imageView.layer.cornerRadius = Configs.cornerRadius
            imageView.layer.masksToBounds = true
            imageView.frame = CGRect(x: 0, y: 0, width: Configs.imageWidth, height: Configs.imageHeight)
//            cell.addSubview(imageView)
            cell.backgroundView = imageView
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.section*defaultRowNumber+indexPath.row
        if index < viewModel.favs.count {
            let fav = viewModel.favs[index]
            var butterfly = Butterfly()
            butterfly.name = fav.name!
            butterfly.butterflyId = Int(fav.butterflyId)
            butterfly.pictures = [fav.picture!]
            
            let pictureViewController = PictureViewController()
            pictureViewController.viewModel.butterfly = butterfly
            pictureViewController.viewModel.isFromFav = true
            self.navigationController?.pushViewController(pictureViewController, animated: true)
        }
    }
}

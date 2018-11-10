//
//  PictureViewController.swift
//  Butterfly
//
//  Created by Songbai Yan  on 2018/11/9.
//  Copyright © 2018 Songbai Yan . All rights reserved.
//

import Foundation
import UIKit

class PictureViewController: UIViewController {
    let viewModel: PictureViewModel = ViewModelFactory.shared.create()
    
    private var scrollView = UIScrollView()
    private var pageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
    }
    
    private func initUI() {
        self.title = viewModel.butterfly.name
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        let rightItem = UIBarButtonItem(image: #imageLiteral(resourceName: "more"), style: .plain, target: self, action: #selector(PictureViewController.openMenu(_:)))
        self.navigationItem.rightBarButtonItem = rightItem
        
        scrollView.frame = self.view.frame
        self.view.addSubview(scrollView)
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(width: self.width*9, height: 0)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = UIColor.background
        scrollView.delegate = self
        
        let screenHeight = UIScreen.main.bounds.height
        let navController = self.navigationController!
        let top = navController.view.safeAreaInsets.top
        let bottom = navController.view.safeAreaInsets.bottom
        let safeHeight = screenHeight - top - bottom - navController.navigationBar.height
        for i in 0..<viewModel.butterfly.pictures.count {
            let imageView = UIImageView(image: UIImage(named: viewModel.butterfly.pictures[i]))
            let height = imageView.height > safeHeight ? safeHeight : imageView.height
            imageView.frame = CGRect(x: self.width*CGFloat(i), y: 0, width: width, height: height)
            imageView.contentMode = .scaleAspectFit
            scrollView.addSubview(imageView)
        }
        
        pageControl.numberOfPages = viewModel.butterfly.pictures.count
        pageControl.backgroundColor = UIColor.clear
        pageControl.pageIndicatorTintColor = UIColor.gray
        pageControl.currentPageIndicatorTintColor = UIColor.white
        self.view.addSubview(pageControl)
        pageControl.addTarget(self, action: #selector(PictureViewController.pageControlClick(_:)), for: .valueChanged)
        pageControl.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(80)
        }
        
        setCurrentPage()
    }
    
    @objc func openMenu(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "收藏与保存", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let favAction = UIAlertAction(title: "收藏", style: UIAlertAction.Style.default) { (_) in
            self.addFav()
        }
        let saveAction = UIAlertAction(title: "保存到相册", style: UIAlertAction.Style.default) { (_) in
            self.saveToAlbum()
        }
        alertController.addAction(favAction)
        alertController.addAction(saveAction)
        alertController.addAction(UIAlertAction(title: "取消", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func addFav() {
        print(self.pageControl.currentPage)
    }
    
    private func saveToAlbum() {
        print(self.pageControl.currentPage)
    }
    
    private func setCurrentPage() {
        pageControl.currentPage = viewModel.currentSelected
        self.scrollView.contentOffset = CGPoint(x: CGFloat(pageControl.currentPage)*self.scrollView.width, y: self.scrollView.contentOffset.y)
    }
    
    @objc func pageControlClick(_ pageControl: UIPageControl) {
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset = CGPoint(x: CGFloat(pageControl.currentPage)*self.scrollView.width, y: self.scrollView.contentOffset.y)
        }
    }
}

extension PictureViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
        self.viewModel.currentSelected = Int(pageNumber)
    }
}
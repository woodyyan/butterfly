//
//  PictureViewController.swift
//  Butterfly
//
//  Created by Songbai Yan  on 2018/11/9.
//  Copyright © 2018 Songbai Yan . All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class PictureViewController: UIViewController {
    let viewModel: PictureViewModel = ViewModelFactory.shared.create()
    
    private var scrollView = UIScrollView()
    private var pageControl = UIPageControl()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ALBBMANPageHitHelper.getInstance()?.pageAppear(self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        ALBBMANPageHitHelper.getInstance()?.pageDisAppear(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
    }
    
    private func initUI() {
        self.title = viewModel.butterfly.name
        
        self.navigationController?.navigationBar.barTintColor = UIColor.background
        self.navigationController?.navigationBar.backgroundColor = UIColor.background
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.themeColor]
        self.navigationController?.navigationBar.tintColor = UIColor.themeColor
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        
        let rightItem = UIBarButtonItem(image: #imageLiteral(resourceName: "more"), style: .plain, target: self, action: #selector(PictureViewController.openMenu(_:)))
        self.navigationItem.rightBarButtonItem = rightItem
        
        scrollView.frame = self.view.frame
        self.view.addSubview(scrollView)
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(width: self.width*CGFloat(viewModel.butterfly.pictures.count), height: 0)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = UIColor.background
        scrollView.delegate = self
        
        addImagesToScrollView()
        
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
    
    private func addImagesToScrollView() {
        for i in 0..<viewModel.butterfly.pictures.count {
            if canAccess(i) {
                scrollView.addSubview(getNormalImage(viewModel.butterfly.pictures[i], i))
            } else {
                scrollView.addSubview(getSubImageView(viewModel.butterfly.pictures[i], i))
            }
        }
    }
    
    private func resetScrollView() {
        scrollView.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        addImagesToScrollView()
        setCurrentPage()
    }
    
    private func getSubImageView(_ key: String, _ index: Int) -> UIView {
        let baseView = UIView(frame: self.view.frame)
        
        let screenHeight = UIScreen.main.bounds.height
        let navController = self.navigationController!
        let top = navController.view.safeAreaInsets.top
        let bottom = navController.view.safeAreaInsets.bottom
        let safeHeight = screenHeight - top - bottom - navController.navigationBar.height
        let image = ImageCache.default.retrieveImageInDiskCache(forKey: key)
        let imageView = UIImageView(image: image)
        let height = imageView.height > safeHeight ? safeHeight : imageView.height
        baseView.frame = CGRect(x: self.width*CGFloat(index), y: 0, width: width, height: height)
        imageView.contentMode = .scaleAspectFit
        baseView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.width.height.equalToSuperview()
        }
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.view.bounds
        imageView.addSubview(blurView)
        
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setTitle("¥订阅会员", for: UIControl.State.normal)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.backgroundColor = UIColor.themeColor
        button.layer.cornerRadius = 18
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(PictureViewController.openSubController(_:)), for: UIControl.Event.touchUpInside)
        baseView.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.width.equalTo(240)
            make.height.equalTo(36)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        return baseView
    }
    
    @objc func openSubController(_ sender: UIButton) {
        let subViewController = SubViewController()
        subViewController.delegate = self
        self.present(subViewController, animated: true, completion: nil)
    }
    
    private func getNormalImage(_ key: String, _ index: Int) -> ImageView {
        let screenHeight = UIScreen.main.bounds.height
        let navController = self.navigationController!
        let top = navController.view.safeAreaInsets.top
        let bottom = navController.view.safeAreaInsets.bottom
        let safeHeight = screenHeight - top - bottom - navController.navigationBar.height
        let image = ImageCache.default.retrieveImageInDiskCache(forKey: key)
        let imageView = UIImageView(image: image)
        let height = imageView.height > safeHeight ? safeHeight : imageView.height
        imageView.frame = CGRect(x: self.width*CGFloat(index), y: 0, width: width, height: height)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    @objc func openMenu(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "收藏与保存", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let favExists = self.viewModel.favExists(self.pageControl.currentPage)
        let favTitle = favExists ? "取消收藏" : "收藏"
        let favAction = UIAlertAction(title: favTitle, style: UIAlertAction.Style.default) { (_) in
            if favExists {
                self.removeFav()
            } else {
                self.addFav()
            }
        }
        favAction.isEnabled = canAccess(self.pageControl.currentPage)
        
        let saveAction = UIAlertAction(title: "保存到相册", style: UIAlertAction.Style.default) { (_) in
            self.saveToAlbum()
        }
        saveAction.isEnabled = canAccess(self.pageControl.currentPage)
        alertController.addAction(favAction)
        alertController.addAction(saveAction)
        alertController.addAction(UIAlertAction(title: "取消", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func addFav() {
        let imageName = self.viewModel.butterfly.pictures[self.pageControl.currentPage]
        let success = self.viewModel.addFav(picture: imageName)
        if success {
            MessageBox.show("收藏成功")
        }
    }
    
    private func removeFav() {
        let imageName = self.viewModel.butterfly.pictures[self.pageControl.currentPage]
        let success = self.viewModel.removeFav(picture: imageName)
        if success {
            MessageBox.show("取消成功")
        }
    }
    
    private func saveToAlbum() {
        let imageName = self.viewModel.butterfly.pictures[self.pageControl.currentPage]
        if let image = ImageCache.default.retrieveImageInDiskCache(forKey: imageName) {
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(PictureViewController.image(image:didFinishSavingWithError:contextInfo:)), nil)
        }
    }
    
    @objc func image(image: UIImage, didFinishSavingWithError: NSError?, contextInfo: AnyObject) {
        if didFinishSavingWithError != nil {
            print(didFinishSavingWithError ?? "")
            MessageBox.show("保存失败")
            return
        }
        MessageBox.show("保存成功")
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
    
    private func canAccess(_ index: Int) -> Bool {
        let isSubscribed = SubscriptionManager.shared.isSubscribed()
        return isSubscribed || index < viewModel.freePicCount || viewModel.isFromFav
    }
}

extension PictureViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
        self.viewModel.currentSelected = Int(pageNumber)
    }
}

extension PictureViewController: Subscription {
    func subscribed() {
        self.resetScrollView()
    }
}

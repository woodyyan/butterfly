//
//  BaseTableCell.swift
//  Butterfly
//
//  Created by Songbai Yan  on 2018/11/6.
//  Copyright © 2018 Songbai Yan . All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class ImageScrollTalbeCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initUI() {
        self.backgroundColor = UIColor.background
        
        let label = UILabel()
        label.text = "abc"
        label.textColor = UIColor.themeColor
        
        let scrollView = buildScrollView()
        
        let cellView = UIStackView(arrangedSubviews: [label, scrollView])
        cellView.frame = self.frame
        cellView.axis = .vertical
        self.addSubview(cellView)
        cellView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
        label.snp.makeConstraints { (make) in
            make.left.equalTo(10)
        }
        scrollView.snp.makeConstraints { (make) in
            make.right.left.bottom.equalToSuperview()
            make.top.equalTo(label.snp.bottom)
        }
    }
    
    private func buildScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.themeColor
        
        let width = 100
        let height = 150
        let margin = 10
        for index in 0...9 {
            let imageView = buildImageView()
            imageView.frame = CGRect(x: index*(width+margin) + margin, y: margin, width: width, height: height)
            scrollView.addSubview(imageView)
        }
        
        scrollView.contentSize = CGSize(width: 70*9, height: scrollView.frame.height)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }
    
    private func buildImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.green
        
        return imageView
    }
}

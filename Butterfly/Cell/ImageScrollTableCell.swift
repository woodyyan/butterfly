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
    
    weak var delegate: ImageScrollTableCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initUI(butterfly: Butterfly) {
        self.backgroundColor = UIColor.background
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = butterfly.name
        label.textColor = UIColor.themeColor
        
        let scrollView = buildScrollView(butterfly)
        
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
    
    private func buildScrollView(_ butterfly: Butterfly) -> UIScrollView {
        let scrollView = UIScrollView()
        
        let width = 100
        let height = 150
        let margin = 10
        var index = 0
        for pic in butterfly.pictures {
            let imageView = TapImageView(image: UIImage(named: pic))
            imageView.delegate = self
            imageView.frame = CGRect(x: index*(width+margin) + margin, y: margin, width: width, height: height)
            scrollView.addSubview(imageView)
            index += 1
        }
        
        scrollView.contentSize = CGSize(width: 70*9, height: scrollView.frame.height)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }
}

protocol ImageScrollTableCellDelegate: NSObjectProtocol {
    func imageScrollTableCell(tableCell: ImageScrollTalbeCell, data: Any?)
}

extension ImageScrollTalbeCell: TapImageViewDelegate {
    func tapImageView(imageView: TapImageView, data: Any?) {
        self.delegate?.imageScrollTableCell(tableCell: self, data: data)
    }
}

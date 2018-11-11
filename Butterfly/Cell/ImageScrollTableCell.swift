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
    private var butterfly: Butterfly?
    
    weak var delegate: ImageScrollTableCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initUI(butterfly: Butterfly) {
        self.butterfly = butterfly
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
        
        let margin = 10
        var index = 0
        for pic in butterfly.pictures {
            let imageView = TapImageView(image: UIImage(named: pic))
            imageView.picture = pic
            imageView.delegate = self
            imageView.frame = CGRect(x: index*(Configs.imageWidth + margin) + margin, y: margin, width: Configs.imageWidth, height: Configs.imageHeight)
            scrollView.addSubview(imageView)
            index += 1
        }
        
        let contentWidth: CGFloat = CGFloat((Configs.imageWidth + margin) * butterfly.pictures.count)
        scrollView.contentSize = CGSize(width: contentWidth, height: scrollView.frame.height)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }
}

protocol ImageScrollTableCellDelegate: NSObjectProtocol {
    func imageScrollTableCell(tableCell: ImageScrollTalbeCell, butterfly: Butterfly, selected: Int)
}

extension ImageScrollTalbeCell: TapImageViewDelegate {
    func tapImageView(imageView: TapImageView) {
        let index = self.butterfly!.pictures.firstIndex(of: imageView.picture)
        self.delegate?.imageScrollTableCell(tableCell: self, butterfly: self.butterfly!, selected: index!)
    }
}

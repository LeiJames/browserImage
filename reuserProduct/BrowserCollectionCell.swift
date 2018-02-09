//
//  BrowserCollectionCell.swift
//  reuserProduct
//
//  Created by Lin YiPing on 2018/2/7.
//  Copyright © 2018年 LeoFeng. All rights reserved.
//

import UIKit

class BrowserCollectionCell: UICollectionViewCell {
    
    private lazy var baseScrollView:UIScrollView = {
        
        var tempScrollView = UIScrollView(frame: self.bounds)
        tempScrollView.showsHorizontalScrollIndicator = false
        tempScrollView.showsVerticalScrollIndicator = false
        tempScrollView.minimumZoomScale = 1.0
        tempScrollView.maximumZoomScale = 3.0
        tempScrollView.delegate = self
        tempScrollView.isPagingEnabled = false
        return tempScrollView
    }()
    private var imageView : UIImageView = {
        
        var lazyImageView = UIImageView()
        lazyImageView.contentMode = .scaleAspectFit
        return lazyImageView
    }()
    
     override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.setupBrowserCell();
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
      
    }
    
    //开始UI布局
    private func setupBrowserCell() {
        
        self.imageView.frame = self.bounds;
        self.baseScrollView.addSubview(self.imageView)
        self.addSubview(self.baseScrollView)
    }
    
    
    func refreshView(_ showImageView:UIImageView) {

       self.imageView.image = showImageView.image
        
    }

}

extension BrowserCollectionCell : UIScrollViewDelegate {
    
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return self.imageView
    }
    
}




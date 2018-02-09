//
//  PhotoBrowser.swift
//  reuserProduct
//
//  Created by Lin YiPing on 2018/2/7.
//  Copyright © 2018年 LeoFeng. All rights reserved.
//

import UIKit

let kSCreenW = UIScreen.main.bounds.size.width

let KSCreenH = UIScreen.main.bounds.size.height

let MainWindow:UIWindow = UIApplication.shared.delegate!.window!!

let ScreenRatio = KSCREENW / KSCreenH
let ScreenMidX =  KSCREENW / 2
let ScreenMidY = KSCreenH / 2

class PhotoBrowser: UIView {
    
    private static let cellID = "cellID"
    private var currentIndex = 0
    lazy var viewBackground:UIView = {
        
        var baseView = UIView(frame: self.bounds)
        baseView.backgroundColor = UIColor.black
        return baseView
    }()
    
    lazy var browserCollectionView:UICollectionView = {
        
         let layout = UICollectionViewFlowLayout()
         layout.scrollDirection = .horizontal
         var collectionView = UICollectionView(frame: self.bounds, collectionViewLayout:layout)
         collectionView.delegate = self
         collectionView.dataSource = self
         collectionView.isHidden = true
         collectionView.showsVerticalScrollIndicator = false
         collectionView.showsHorizontalScrollIndicator = false
         collectionView.bounces = false
         collectionView.isPagingEnabled = true
         collectionView.register(BrowserCollectionCell.self, forCellWithReuseIdentifier: PhotoBrowser.cellID)
         return collectionView
    }()
    
    private var imageArray:[UIImageView] = {
        
        var array = [UIImageView]();
        return array
    }()
    
    init () {
       
       super.init(frame: CGRect.zero)
       self.setupPhotoBrowser()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    private func setupPhotoBrowser () {
        
        self.frame = MainWindow.bounds
        MainWindow.addSubview(self)
        self.addSubview(self.viewBackground)
        self.addSubview(self.browserCollectionView)
        self.viewBackground.alpha = 0;
    }
    //播放图片方法
    func browserImage(_ imageArray:Array<UIImageView>, currentImageIndex:Int) {
        
        self.imageArray = imageArray
        self.currentIndex = currentImageIndex
        let currentImageView = imageArray[currentImageIndex]
        self.animationView(currentImageView: currentImageView)
  
    
    }
    
   
    
    
    private  func animationView(currentImageView:UIImageView) {
        
        currentImageView.isHidden = true
        let image = currentImageView.image!
        let scaleFactor = image.size.width / image.size.height
        var startFrame = currentImageView.superview!.convert(currentImageView.frame, to: MainWindow)
        print("转化之后的\(startFrame)")
        var endFrame = UIScreen.main.bounds
        
        //开始的时候转化到当前window时候的宽高比计算
        if scaleFactor < startFrame.size.width / startFrame.size.height {
            //宽小于高的时候的图片
            let midX = startFrame.midX
            startFrame.size.width = startFrame.height * scaleFactor
            startFrame.origin.x = midX - startFrame.size.width / 2
            print("1\(startFrame)")
        }else {
            let midY = startFrame.midY
            startFrame.size.height = startFrame.size.width / scaleFactor
            startFrame.origin.y = midY - startFrame.size.height / 2
            print("2\(startFrame)")
        }
        
        
        //结束的时候按整个屏幕的宽高比计算
        if scaleFactor < ScreenRatio {
            endFrame.size.width = KSCREENW * scaleFactor;
            endFrame.origin.x = ScreenMidX - endFrame.size.width / 2
            print("3\(endFrame)")
        } else {
            endFrame.size.height = KSCreenH / scaleFactor;
            endFrame.origin.y = ScreenMidY - endFrame.size.height / 2
            print("4\(endFrame)")
        }

        let tempImageView = UIImageView(frame: startFrame)
        tempImageView.image = currentImageView.image
        tempImageView.contentMode = .scaleAspectFit
        MainWindow.addSubview(tempImageView)
  
        
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseIn,
                       animations: { () -> Void in
            tempImageView.frame = endFrame
            self.viewBackground.alpha = 1

        }) { (commplete) -> Void in
            currentImageView.isHidden = false
            self.browserCollectionView.contentOffset = CGPoint(x: KSCREENW * CGFloat(self.currentIndex), y: 0)
            self.browserCollectionView.isHidden = false
            tempImageView.removeFromSuperview()

        }
    }
    
}


extension PhotoBrowser: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.imageArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let browserCell:BrowserCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoBrowser.cellID, for: indexPath) as! BrowserCollectionCell
        let gesture = UITapGestureRecognizer(target: self, action: #selector(clickImage(gesture:)))
        browserCell.addGestureRecognizer(gesture)
        browserCell.refreshView(self.imageArray[indexPath.row])
        return browserCell
    }
    
    @objc private func clickImage(gesture:UITapGestureRecognizer) {
        
       self.removeFromSuperview()
    }
}

extension PhotoBrowser : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        return UIScreen.main.bounds.size
    }
    
}


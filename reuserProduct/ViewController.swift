//
//  ViewController.swift
//  reuserProduct
//
//  Created by Lin YiPing on 2018/1/8.
//  Copyright © 2018年 LeoFeng. All rights reserved.
//

import UIKit

let KSCREENW = UIScreen.main.bounds.size.width;

let KSCREENH = UIScreen.main.bounds.size.height;

class ViewController: UIViewController{
    
    var imageArray:Array<UIImageView>?
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        //开始的frame 是将当前的imageView在父视图的位置转化为在 "当前window的位置"
        /*
         
         1) 算出当期图片的宽高比     当前图片的比例  =   当前图片的宽度 / 当前图片的高度
         
         2）判断
        
         if (当期图片的比例 < )
 
 
         */
        
        let myImageView = UIImageView(image: UIImage(named: "my"))
        self.imageArray = [UIImageView]()
        let imageView = UIImageView(image: UIImage(named: "image4"))
        imageView.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        let gesture = UITapGestureRecognizer(target: self, action: #selector(clickImage(gesture:)))
        imageView.addGestureRecognizer(gesture)
        self.view.addSubview(imageView)
        self.imageArray?.append(imageView)
        self.imageArray?.append(myImageView)

         
       
    
    }
    
    @objc private func clickImage(gesture:UIGestureRecognizer) {
        
        let browser = PhotoBrowser()
        if let imageArray = self.imageArray {
            
          browser.browserImage(imageArray, currentImageIndex: 0);
        
        }
      
        
    }
}







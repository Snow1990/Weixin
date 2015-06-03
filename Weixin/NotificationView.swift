//
//  NotificationView.swift
//  Weixin
//
//  Created by SN on 15/6/2.
//  Copyright (c) 2015年 Snow. All rights reserved.
//

import UIKit

class NotificationView: UIView {
    
    let fontSize:CGFloat = 16
    var notificationCount = 0
    var imageView = UIImageView()
    var countLable = UILabel()
    
    override init(frame:CGRect) {
        
        super.init(frame: frame)
        
        imageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
        self.addSubview(imageView)
        
        countLable.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
        countLable.textColor = UIColor.whiteColor()
        countLable.font = UIFont.systemFontOfSize(fontSize)
        countLable.textAlignment = NSTextAlignment.Center
        self.addSubview(countLable)
        
        self.userInteractionEnabled = false

    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addNotifications(n:Int){
        notificationCount = n
        self.updateImageView()
    }
    
    func removeNotifications(){
        notificationCount = 0
        self.updateImageView()
    }
   
    func updateImageView(){
        
        let image = UIImage(named: Constants.NotificationCircleImg)
        
        if notificationCount >= 100{
            imageView.image = image
            countLable.text = "99+"
        }else if notificationCount > 0{
            imageView.image = image
            countLable.text = "\(notificationCount)"
        }else{
            imageView.image = nil
            countLable.text = ""
        }
    }
}


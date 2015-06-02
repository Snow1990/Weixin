//
//  InputToolBar.swift
//  Weixin
//
//  Created by SN on 15/6/2.
//  Copyright (c) 2015年 Snow. All rights reserved.
//

import UIKit

class InputToolBar: UIView {

    var backgroundImageView = UIImageView()
    var textFieldBackground = UIImageView()
    var textField = UITextField()
    var leftBtn = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
    var smileBtn = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
    var addBtn = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
    
//    var delegate: FHInputToolbarDelegate?
    
    override init(frame: CGRect) {
        
        
        super.init(frame: frame)
        
//        self.frame = CGRectMake(frame.origin.x, frame.origin.y, UIScreen.mainScreen().bounds.width, 44)
        let screenRect : CGRect = UIScreen.mainScreen().bounds
        
        self.backgroundImageView.frame = CGRectMake(0, 0, self.frame.width, self.frame.height)
        self.backgroundImageView.image = UIImage.resizableImage(Constants.ChatToolBarBgImg)
        addSubview(self.backgroundImageView)
        
        self.leftBtn.frame = CGRectMake(5, 5, 34, 34)
        self.leftBtn.setBackgroundImage(UIImage(named: Constants.ChatVoiceBtnIco), forState: UIControlState.Normal)
        addSubview(self.leftBtn)
        
        self.textFieldBackground.frame = CGRectMake(34 + 5 * 2, 5, screenRect.width - 34 * 3 - 5 * 8, 34)
        self.textFieldBackground.image = UIImage(named: Constants.ChatTextfieldImg)
        addSubview(self.textFieldBackground)
        
        self.textField.frame = CGRectMake(self.textFieldBackground.frame.origin.x + 5, 5, self.textFieldBackground.frame.width - 10, 34)
        self.textField.borderStyle = UITextBorderStyle.None
        self.textField.backgroundColor = UIColor.clearColor()
        self.textField.placeholder = "请输入..."
//        self.textField.delegate = self
        addSubview(self.textField)
        
        self.smileBtn.frame = CGRectMake(screenRect.width - 34 * 2 - 5 * 3, 5, 34, 34)
        self.smileBtn.setBackgroundImage(UIImage(named: Constants.ChatSmileBtnIco), forState: UIControlState.Normal)
//        self.smileBtn.addTarget(self, action: "onRightBtnTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        addSubview(self.smileBtn)
        
        self.addBtn.frame = CGRectMake(screenRect.width - 34 - 5, 5, 34, 34)
        self.addBtn.setBackgroundImage(UIImage(named: Constants.ChatAddBtnIco), forState: UIControlState.Normal)
//        self.addBtn.addTarget(self, action: "onRightBtnTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        addSubview(self.addBtn)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
//    func onRightBtnTapped(sender: AnyObject){
//        self.delegate?.onInputBtnTapped(self.textField.text)
//        self.textField.text = ""
//    }
    
//    //textField delegate
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        
//        self.textField.resignFirstResponder()
//        
//        return false
//    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    
}
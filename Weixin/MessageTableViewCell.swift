//
//  MessageTableViewCell.swift
//  Weixin
//
//  Created by SN on 15/6/2.
//  Copyright (c) 2015年 Snow. All rights reserved.
//

import UIKit


class MessageTableViewCell: UITableViewCell {
    
    var avatar = UIImageView()
    var messageLabel = UILabel()
    var messageBackgroundImageView = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        messageLabel.font = Constants.ChatFont
        messageLabel.numberOfLines = 0
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(avatar)
        addSubview(messageBackgroundImageView)
        addSubview(messageLabel)
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    class func reuseIdentifier() -> String{
        return Constants.ChatListReusableCellID
    }
    
    class func heightForCell(message: WXMessage) -> CGFloat{
        
        let screenRect : CGRect = UIScreen.mainScreen().bounds
        
        let labelSize: CGSize = UILabel.sizeOfString(message.body, font: Constants.ChatFont, maxWidth: screenRect.width - 10 - 20 - Constants.AvatarSize.width * 2)
        
        var hight = labelSize.height + 20 > Constants.AvatarSize.height ? labelSize.height + 20 : Constants.AvatarSize.height
        return hight + 10
       
    }
    
    func setupMessageCell(message: WXMessage){
        
        let screenRect : CGRect = UIScreen.mainScreen().bounds
        
        let labelSize: CGSize = UILabel.sizeOfString(message.body, font: self.messageLabel.font, maxWidth: screenRect.width - 10 - 20 - Constants.AvatarSize.width * 2)
        
        let messageBackgroundSize: CGSize = CGSizeMake(labelSize.width + 30, labelSize.height + 30)
        
        if message.from.name == zdl().myselfUser.name {
            self.avatar.frame = CGRectMake(screenRect.width - 5 - Constants.AvatarSize.width, 5, Constants.AvatarSize.width, Constants.AvatarSize.height)
            self.avatar.image = UIImage(named: Constants.MyAvatar)
            
            self.messageLabel.text = message.body
            self.messageLabel.frame = CGRectMake(screenRect.width - 5 - self.avatar.frame.width - 5 - 15 - labelSize.width, 15, labelSize.width, labelSize.height)
            self.messageLabel.textAlignment = NSTextAlignment.Left
            
            self.messageBackgroundImageView.image = UIImage.resizableImage(Constants.ChatToBgNormalImg)
            self.messageBackgroundImageView.frame = CGRectMake(screenRect.width - 5 - self.avatar.frame.width - 5 - messageBackgroundSize.width, 5, messageBackgroundSize.width, messageBackgroundSize.height)
        }
        else{
            self.avatar.frame = CGRectMake(5, 5, Constants.AvatarSize.width, Constants.AvatarSize.height)
            self.avatar.image = UIImage(named: message.from.name + "icon")
            
            self.messageLabel.text = message.body
            
            self.messageLabel.frame = CGRectMake(5 + Constants.AvatarSize.width + 5 + 15, 15, labelSize.width, labelSize.height)
            self.messageLabel.textAlignment = NSTextAlignment.Left
            
            self.messageBackgroundImageView.image = UIImage.resizableImage(Constants.ChatFromBgNormalImg)
            self.messageBackgroundImageView.frame = CGRectMake(5 + self.avatar.frame.width + 5, 5, messageBackgroundSize.width, messageBackgroundSize.height)
        }
    }
    
    //获取总代理
    func zdl() -> AppDelegate {
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
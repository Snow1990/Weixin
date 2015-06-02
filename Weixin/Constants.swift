//
//  Constants.swift
//  Weixin
//
//  Created by SN on 15/6/1.
//  Copyright (c) 2015年 Snow. All rights reserved.
//

import Foundation
import UIKit

class Constants{
    //场景过度
    static let ToLoginSegue = "toLoginSegue"
    static let ToChatSegue = "toChatSegue"
    
    //重用CellID
    static let BuddyListReusableCellID = "buddyListCell"
    static let ChatListReusableCellID = "chatListCell"
    
    
    //用户状态
    static let Available = "available"
    static let Unavailable = "unavailable"
    static let Domain = "mymacbookpro.local"

    //NSUserDefault键值
    static let UserName = "weixinUserName"
    static let Password = "weixinPassword"
    static let Server = "weixinServer"
    static let AutoLogin = "weixinAutoLogin"


    //图片名称
    static let LoginBGImg = "LoginBackground"
    static let OnlineIco = "在线"
    static let OfflineIco = "下线"
    static let MyAvatar = "tomicon"
    static let JerryAvatar = "jerryicon"
    static let DogAvatar = "dogicon"
    static let ChatToBgNormalImg = "chatto_bg_normal"
    static let ChatFromBgNormalImg = "chatfrom_bg_normal"
    static let ChatBgDefaultImg = "chat_bg_default"
    static let ChatToolBarBgImg = "toolbar_bottom_bar"
    static let ChatVoiceBtnIco = "chat_bottom_voice_nor"
    static let ChatSmileBtnIco = "chat_bottom_smile_nor"
    static let ChatAddBtnIco = "chat_bottom_up_nor"
    static let ChatTextfieldImg = "chat_bottom_textfield"
    static let NotificationCircleImg = "计数"
    static let NotificationEllipseImg = "计数02"
    
    //图像大小
    static let AvatarSize : CGSize = CGSize(width: 45, height: 45)
    static let ChatFont = UIFont.systemFontOfSize(16)

}
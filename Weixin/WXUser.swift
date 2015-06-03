//
//  User.swift
//  Weixin
//
//  Created by SN on 15/6/1.
//  Copyright (c) 2015年 Snow. All rights reserved.
//

import Foundation

//用户状态委托
protocol WXUserDelegate{
    func isOn(user:WXUser)
    func isOff(user:WXUser)
    func meOn(user:WXUser)
}

//微信用户
class WXUser {
    
    var name = ""
    var presence = ""
    var domain = Constants.Domain
    //用户为自己才用的属性
    var password: String?
    
    var isOnline: Bool{
        if self.presence == Constants.Available{
            return true
        }else{
            return false
        }
    }
    var fullName: String{
        return name + "@" + domain
    }

    init(){}
    
    init(presence: XMPPPresence){
        self.name = presence.from().user
        self.domain = presence.from().domain
        self.presence = presence.type()

    }
    
    init(message: XMPPMessage){
        self.name = message.from().user
        self.domain = message.from().domain
        self.presence = message.type()
        
    }
}
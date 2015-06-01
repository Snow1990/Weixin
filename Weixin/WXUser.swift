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
    
}


//微信用户
class WXUser {
    var name = ""
    var isOnline = false
}
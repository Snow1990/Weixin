//
//  Message.swift
//  Weixin
//
//  Created by SN on 15/6/1.
//  Copyright (c) 2015年 Snow. All rights reserved.
//

import Foundation

//消息委托
protocol WXMessageDelegate{
    func newMessage(message: WXMessage)
}


//消息
class WXMessage{
    var body = ""
    var from: WXUser!
    var isComposing = false
    var isDelay = false
    
}
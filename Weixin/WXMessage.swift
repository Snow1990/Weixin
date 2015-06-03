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
    
    init(){}
    
    init(body: String, from: WXUser) {
        self.body = body
        self.from = from
    }
    
    init(message: XMPPMessage){
        
        //正在输入
        if message.elementForName("composing") != nil {
            self.isComposing = true
        }
        //离线消息
        if message.elementForName("delay") != nil {
            self.isDelay = true
        }
        //消息正文
        if let body = message.elementForName("body"){
            self.body = body.stringValue()
        }
        //消息来源
        self.from = WXUser(message: message)
    }
}
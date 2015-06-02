//
//  ChatViewController.swift
//  Weixin
//
//  Created by SN on 15/6/1.
//  Copyright (c) 2015年 Snow. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, WXMessageDelegate {

    //当前聊天好友
    var toBuddy: WXUser!
    //聊天消息
    var messages = [WXMessage]()
    
    @IBOutlet weak var messageTF: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func send(sender: UIBarButtonItem) {
        //获取聊天框内容
        let msgStr = messageTF.text
        
        //如果文本不为空
        if !msgStr.isEmpty {
            //构建XML元素
            var xmlMessage = DDXMLElement.elementWithName("message") as! DDXMLElement
            
            //增加属性
            xmlMessage.addAttributeWithName("type", stringValue: "chat")
            xmlMessage.addAttributeWithName("to", stringValue: toBuddy.fullName)
            xmlMessage.addAttributeWithName("from", stringValue: zdl().myselfUser.fullName)
            
            //构建正文
            var body = DDXMLElement.elementWithName("body") as! DDXMLElement
            body.setStringValue(msgStr)
            
            //在正文中加入消息子节点
            xmlMessage.addChild(body)
            
            //通过通道发送xml文本
            zdl().xmppStream?.sendElement(xmlMessage)
            
            //清空聊天框
            messageTF.text = ""
            
            //保存自己的信息
            let myMsg = WXMessage(body: msgStr, from: zdl().myselfUser)
            messages.append(myMsg)
            self.tableView.reloadData()
            
        }
    }
    
    func composing (sender: UITextField){
        
        //构建XML元素
        var xmlMessage = DDXMLElement.elementWithName("message") as! DDXMLElement
        
        //增加属性
        xmlMessage.addAttributeWithName("to", stringValue: toBuddy.fullName)
        xmlMessage.addAttributeWithName("from", stringValue: zdl().myselfUser.fullName)
        
        //构建正在输入
        var composing = DDXMLElement.elementWithName("composing") as! DDXMLElement
        composing.addAttributeWithName("xmlns", stringValue: "http://jabber.org/protocol/chatstates")
        
        
        xmlMessage.addChild(composing)
        
        //通过通道发送xml文本
        zdl().xmppStream?.sendElement(xmlMessage)
        

    }

    //收到消息
    func newMessage(message: WXMessage) {
        
        //对方正在输入
        if message.isComposing {
            self.navigationItem.title = "对方正在输入..."
            
        //如果消息有正文，加入到消息组
        }else if (message.body != "") {
            
            self.navigationItem.title = toBuddy.name

            //则加入到未读消息列表
            messages.append(message)
            
            self.tableView.reloadData()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor(patternImage: UIImage(named: Constants.ChatBgDefaultImg)!)
        zdl().wxMessageDelegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var reuseableCell: MessageTableViewCell!
        if let cell = tableView.dequeueReusableCellWithIdentifier(Constants.ChatListReusableCellID) as? MessageTableViewCell{
            reuseableCell = cell
        }else{
            reuseableCell = MessageTableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: Constants.ChatListReusableCellID)
        }
        
        let msg = messages[indexPath.row]
        
        reuseableCell.selectionStyle = UITableViewCellSelectionStyle.None
        reuseableCell.setupMessageCell(msg)
        
        
        return reuseableCell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let msg = messages[indexPath.row]
        return MessageTableViewCell.heightForCell(msg)
    }
    
    //获取总代理
    func zdl() -> AppDelegate {
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

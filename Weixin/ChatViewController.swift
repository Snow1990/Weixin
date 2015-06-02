//
//  ChatViewController.swift
//  Weixin
//
//  Created by SN on 15/6/1.
//  Copyright (c) 2015年 Snow. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, WXMessageDelegate {

    
    //当前聊天好友
    var toBuddy: WXUser!
    //聊天消息
    var messages = [WXMessage]()
    
    //聊天框工具栏
    var inputToolbar: InputToolBar = InputToolBar(frame: CGRectMake(0, UIScreen.mainScreen().bounds.height - 44, UIScreen.mainScreen().bounds.width, 44))
    
    var tableView: UITableView = UITableView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height - 44))
    
    //发送消息
    func sendMessage(message: String) {
        
        //如果文本不为空
        if !message.isEmpty {
            //构建XML元素
            var xmlMessage = DDXMLElement.elementWithName("message") as! DDXMLElement
            
            //增加属性
            xmlMessage.addAttributeWithName("type", stringValue: "chat")
            xmlMessage.addAttributeWithName("to", stringValue: toBuddy.fullName)
            xmlMessage.addAttributeWithName("from", stringValue: zdl().myselfUser.fullName)
            
            //构建正文
            var body = DDXMLElement.elementWithName("body") as! DDXMLElement
            body.setStringValue(message)
            
            //在正文中加入消息子节点
            xmlMessage.addChild(body)
            
            //通过通道发送xml文本
            zdl().xmppStream?.sendElement(xmlMessage)
            
            //保存自己的信息
            let myMsg = WXMessage(body: message, from: zdl().myselfUser)
            messages.append(myMsg)
            self.tableView.reloadData()
        }
    }
    
    //正在输入
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
            
            scrollToLastRow()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = toBuddy.name
        
        self.tableView.backgroundColor = UIColor(patternImage: UIImage(named: Constants.ChatBgDefaultImg)!)
        self.tableView.separatorStyle = .None
        var gesture = UITapGestureRecognizer(target: self, action: "tableViewTap:")
        self.tableView.addGestureRecognizer(gesture)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.inputToolbar.textField.addTarget(self, action: "composing:", forControlEvents: UIControlEvents.ValueChanged)
        self.inputToolbar.textField.delegate = self
        
        zdl().wxMessageDelegate = self

        
        self.view.addSubview(tableView)
        self.view.addSubview(inputToolbar)
        scrollToLastRow()
        
        
        //keyboard notitication
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        

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
    
    // MARK: - Table view delegate
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
    
    
    // MARK: - Textfield delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        sendMessage(textField.text)
        
        //清空聊天框
        textField.text = ""
        
        scrollToLastRow()

        
        
//        textField.resignFirstResponder()
        return false
    }
    

    // MARK: - Keyboard hides or show
    func keyboardWillShow(notify: NSNotification) {
        
        let userInfo = notify.userInfo!
        let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! Double
        let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        //屏幕尺寸
        let screenRect : CGRect = UIScreen.mainScreen().bounds
        
        UIView.animateWithDuration(duration, animations: { () -> Void in
            self.tableView.frame = CGRectMake(0, 0, screenRect.width, screenRect.height - self.inputToolbar.frame.height - keyboardFrame.height)
            self.inputToolbar.frame.origin.y -= keyboardFrame.height
//            self.inputToolbar.frame = CGRectMake(0, UIScreen.mainScreen().bounds.height-44-keyboardFrame.height, UIScreen.mainScreen().bounds.width, 44)
        })
        scrollToLastRow()
    }
    
    func keyboardWillHide(notify: NSNotification){
        
        let userInfo = notify.userInfo!
        let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! Double
        let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        //屏幕尺寸
        let screenRect : CGRect = UIScreen.mainScreen().bounds
        
        UIView.animateWithDuration(duration, animations: { () -> Void in
            self.tableView.frame = CGRectMake(0, 0, screenRect.width, screenRect.height - self.inputToolbar.frame.height)
            self.inputToolbar.frame.origin.y += keyboardFrame.height

//            self.inputToolbar.frame = CGRectMake(0, UIScreen.mainScreen().bounds.height-44, UIScreen.mainScreen().bounds.width, 44)
        })
        scrollToLastRow()
    }
    
    
    // MARK: - 手势操作
    func tableViewTap(sender: UITapGestureRecognizer) {
        self.inputToolbar.textField.resignFirstResponder()
    }


    // MARK: - 公共方法
    //获取总代理
    func zdl() -> AppDelegate {
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
    
    //滚动到最后一行
    func scrollToLastRow(){
        if !messages.isEmpty{
            let path: NSIndexPath = NSIndexPath(forRow: self.messages.count - 1, inSection: 0)
            self.tableView.scrollToRowAtIndexPath(path, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
        }
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

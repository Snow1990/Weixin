//
//  BuudyListTableViewController.swift
//  Weixin
//
//  Created by SN on 15/6/1.
//  Copyright (c) 2015年 Snow. All rights reserved.
//

import UIKit

class BuudyListTableViewController: UITableViewController, WXUserDelegate, WXMessageDelegate {
    
//    //已登入
//    var logged = false
    //好友列表
    var userList = [WXUser](){
        didSet{
            self.tableView.reloadData()
        }
    }
    //未读消息
    var unreadMessages = [WXMessage]()
    
    //当前好友
    var currentBuddy: WXUser?
    
//    var a = NSMutableOrderedSet()
    
    @IBOutlet weak var myStatus: UIBarButtonItem!
    @IBAction func log(sender: UIBarButtonItem) {
        if zdl().myselfUser.isOnline {
            //下线
            logoff()
            //图片改为离线
//            sender.title = "离线"
//            sender.image = UIImage(named: Constants.OnlineIco)
        }else {
            //上线
            login()
            //图片改为上线
//            sender.title = "在线"
//            sender.image = UIImage(named: Constants.OfflineIco)
        }
    }
    
    //自己上线
    func meOn(user: WXUser) {
        if zdl().myselfUser.isOnline {
            myStatus.enabled = true
            myStatus.title = "在线"
        }
    }
    
    
    //好友上线
    func isOn(user: WXUser) {
        //逐条查找
        for oldUser in userList {
            //如果找到旧的用户状态
            if oldUser.name == user.name {
                oldUser.presence = Constants.Available
                self.tableView.reloadData()
                return
            }

        }
        //如果找不到，添加新用户
        userList.append(user)
        
//        self.tableView.reloadData()
        
    }
    //好友下线
    func isOff(user: WXUser) {
        
        //逐条查找
        for oldUser in userList {
            //如果找到旧的用户状态
            if oldUser.name == user.name {
                oldUser.presence = Constants.Unavailable
                self.tableView.reloadData()

                return
            }
            
        }
        //如果找不到，添加新用户
        userList.append(user)
        
//        self.tableView.reloadData()
        
    }
    //收到消息
    func newMessage(message: WXMessage) {
        //如果消息有正文，加入到未读消息组
        if (message.body != "") {
            //则加入到未读消息列表
            unreadMessages.append(message)
            self.tableView.reloadData()
        }
    }
    

    //登入
    func login(){
        //清空数组
        unreadMessages.removeAll(keepCapacity: false)
        userList.removeAll(keepCapacity: false)
        zdl().connect()

        
//        self.tableView.reloadData()

        
        
    }
    
    //登出
    func logoff(){
        zdl().disConnect()

        myStatus.title = "离线"
        for user in userList {
            user.presence = Constants.Unavailable
        }
        
        
        self.tableView.reloadData()

    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        zdl().wxUserDelegate = self

        //取自动登录
        let aotoLogin = NSUserDefaults.standardUserDefaults().boolForKey(Constants.AutoLogin)
        
        //如果配置了用户名和自动登录
        if aotoLogin {
            
            self.login()
            
        //其他情况，跳转到登录视图
        }else{
            self.performSegueWithIdentifier(Constants.ToLoginSegue, sender: self)
        }
        
    }
    override func viewDidAppear(animated: Bool) {
        zdl().wxMessageDelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return userList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.BListReusableCellID, forIndexPath: indexPath) as! UITableViewCell
        
        //未读消息数目
        var unreads = 0
        
        //取得好友信息
        let user = userList[indexPath.row]
        
        for msg in unreadMessages {
            if user.name == msg.from.name {
                unreads++
            }
        }
        
        //好友名称
        cell.textLabel?.text = user.name + "(\(unreads))"
        
        //根据好友状态，切换单元格图像
        if user.isOnline {
            cell.imageView?.image = UIImage(named: Constants.OnlineIco)
            
        }else {
            cell.imageView?.image = UIImage(named: Constants.OfflineIco)
        }

        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //当前好友
        currentBuddy = userList[indexPath.row]
        
        //跳转到聊天视图
        self.performSegueWithIdentifier(Constants.ToChatSegue, sender: self)
        
        
    }
    


    //获取总代理
    func zdl() -> AppDelegate {
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //判断是否是聊天界面
        if let dest = segue.destinationViewController as? UINavigationController {
            if let chatViewController = dest.viewControllers[0] as? ChatViewController {
                
                //把当前选择的单元格用户传递给聊天视图
                chatViewController.toBuddy = currentBuddy!
                
                //把未读消息传递给聊天视图
                for msg in unreadMessages {
                    if msg.from.name == currentBuddy!.name {
                        //加入到聊天视图消息组中
                        chatViewController.messages.append(msg)
                    }
                }
                
                //把相应的未读消息移除
//                self.removeValueFromArray(currentBuddy!, array: &unreadMessages)
                unreadMessages = unreadMessages.filter{ $0.from.name != self.currentBuddy!.name }
                
                self.tableView.reloadData()
            }
        }
    }
    

    
    @IBAction func unwindToBList(segue: UIStoryboardSegue){
        //如果点击了登录按钮
        if let source = segue.sourceViewController as? LoginViewController {
            
                if source.requireLogin{
                    //注销前一个用户
                    logoff()
                    //登录
                    login()
                }
            
        }
        
        
    }
}

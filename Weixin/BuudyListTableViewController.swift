//
//  BuudyListTableViewController.swift
//  Weixin
//
//  Created by SN on 15/6/1.
//  Copyright (c) 2015年 Snow. All rights reserved.
//

import UIKit

class BuudyListTableViewController: UITableViewController, WXUserDelegate, WXMessageDelegate {
    
    //已登入
    var logged = false
    //好友列表
    var userList = [WXUser]()
    //未读消息
    var unreadMessages = [WXMessage]()
    
//    var a = NSMutableOrderedSet()
    
    @IBOutlet weak var myStatus: UIBarButtonItem!
    //获取总代理
    func zdl() -> AppDelegate {
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
    
    //好友上线
    func isOn(user: WXUser) {
        //逐条查找
        for oldUser in userList {
            //如果找到旧的用户状态
            if oldUser.name == user.name {
                oldUser.presence = Constants.Available
                return
            }

        }
        //如果找不到，添加新用户
        userList.append(user)
        
        self.tableView.reloadData()
        
    }
    //好友下线
    func isOff(user: WXUser) {
        //逐条查找
        for oldUser in userList {
            //如果找到旧的用户状态
            if oldUser.name == user.name {
                oldUser.presence = Constants.Unavailable
                return
            }
            
        }
        //如果找不到，添加新用户
        userList.append(user)
        
        self.tableView.reloadData()
        
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
        
        let myUserName = NSUserDefaults.standardUserDefaults().stringForKey(Constants.UserName)
        self.navigationItem.title = myUserName! + "的好友"
        self.navigationItem.title = myUserName! + "的好友"

        zdl().connect()
        myStatus.image = UIImage(named: Constants.OnlineIco)
        logged = true
        
        self.tableView.reloadData()
    }
    
    //登出
    func logoff(){
        zdl().disConnect()
        myStatus.image = UIImage(named: Constants.OfflineIco)
        logged = false
        
        self.tableView.reloadData()

    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //取用户名
        let myUserName = NSUserDefaults.standardUserDefaults().stringForKey(Constants.UserName)
        //取自动登录
        let aotoLogin = NSUserDefaults.standardUserDefaults().boolForKey(Constants.AutoLogin)
        
        //如果配置了用户名和自动登录
        if (myUserName != nil && aotoLogin){
            
            self.login()
            
            
        //其他情况，跳转到登录视图
        }else{
            self.performSegueWithIdentifier(Constants.ToLoginSegue, sender: self)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 0
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func unwindToBList(segue: UIStoryboardSegue){
        //如果点击了登录按钮
        if let source = segue.sourceViewController as? UINavigationController {
            if let loginController = source.viewControllers[0] as? LoginViewController {
                if loginController.requireLogin{
                    //注销前一个用户
                    logoff()
                    //登录
                    login()
                }
            }
        }
        
        
    }
}

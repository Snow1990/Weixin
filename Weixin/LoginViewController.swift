//
//  LoginViewController.swift
//  Weixin
//
//  Created by SN on 15/6/1.
//  Copyright (c) 2015年 Snow. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    var requireLogin = false
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var serverTF: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var aotoLoginSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: Constants.LoginBGImg)!)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if sender as? UIBarButtonItem == self.doneButton{
            NSUserDefaults.standardUserDefaults().setValue(userNameTF.text, forKey: Constants.UserName)
            NSUserDefaults.standardUserDefaults().setValue(passwordTF.text, forKey: Constants.Password)
            NSUserDefaults.standardUserDefaults().setValue(serverTF.text, forKey: Constants.Server)
            NSUserDefaults.standardUserDefaults().setBool(aotoLoginSwitch.on, forKey: Constants.AutoLogin)
            
            requireLogin = true
            
            //同步用户配置
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        
        
        
    }


}

//
//  BuddyTableViewCell.swift
//  Weixin
//
//  Created by SN on 15/6/2.
//  Copyright (c) 2015年 Snow. All rights reserved.
//

import UIKit

class BuddyTableViewCell: UITableViewCell {
    
    var notificationView: NotificationView?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        notificationView = NotificationView(frame: CGRectMake(UIScreen.mainScreen().bounds.width - 44, 5, 34, 34))
        addSubview(notificationView!)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    class func reuseIdentifier() -> String{
        return Constants.BuddyListReusableCellID
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

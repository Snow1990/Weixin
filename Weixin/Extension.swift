//
//  Extension.swift
//  Weixin
//
//  Created by SN on 15/6/2.
//  Copyright (c) 2015年 Snow. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    class func resizableImage(name: String) -> UIImage {
        
        var image = UIImage(named: name)!
        
        let top: CGFloat = image.size.height * 0.6
        let bottom: CGFloat = image.size.height * 0.5
        let lAndr: CGFloat = image.size.height * 0.5
        
        return image.resizableImageWithCapInsets(UIEdgeInsets(top: top, left: lAndr, bottom: bottom, right: lAndr))
    }
}

extension UILabel {
    class func sizeOfString(string: String, font: UIFont, maxWidth: CGFloat) -> CGSize{
        
        var size: CGSize = string.boundingRectWithSize(CGSizeMake(maxWidth, 999),
            options: NSStringDrawingOptions.UsesLineFragmentOrigin,
            attributes: [NSFontAttributeName: font],
            context: nil).size
        return size
//        return CGSizeMake(size.width + 15, size.height + 20)
    }
}
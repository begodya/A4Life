//
//  BBColor.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 9/30/15.
//  Copyright © 2015 BooYah. All rights reserved.
//

import UIKit

class BBColor: NSObject {
    
    // MARK: - --------------------功能函数--------------------
    
    // MARK: Creates a UIColor from a Hex string.
    @objc private class func colorWithHexString (hex: String, alpha: CGFloat) -> UIColor {
        var cString: String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substringFromIndex(1)
        }
        
        if (cString.size() != 6) {
            return UIColor.grayColor()
        }
        
        let rString = (cString as NSString).substringToIndex(2)
        let gString = ((cString as NSString).substringFromIndex(2) as NSString).substringToIndex(2)
        let bString = ((cString as NSString).substringFromIndex(4) as NSString).substringToIndex(2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0
        NSScanner(string: rString).scanHexInt(&r)
        NSScanner(string: gString).scanHexInt(&g)
        NSScanner(string: bString).scanHexInt(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }

    
    
    // MARK: - --------------------接口API--------------------
    
    // MARK: 颜色接口
    class func titleColor() -> UIColor {
        return BBColor.colorWithHexString("000000", alpha: 1)
    }

    class func detailColor() -> UIColor {
        return BBColor.colorWithHexString("646464", alpha: 1)
    }
    
    class func defaultColor() -> UIColor {
        return BBColor.colorWithHexString("f5f5f5", alpha: 1)
    }
    
    class func redColor() -> UIColor {
        return UIColor.redColor()
    }
    
}

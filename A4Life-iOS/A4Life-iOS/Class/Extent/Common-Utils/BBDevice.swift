//
//  BBDevice.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 9/30/15.
//  Copyright © 2015 BooYah. All rights reserved.
//

import UIKit

class BBDevice: NSObject {
    
    // MARK: - --------------------功能函数--------------------

    
    // MARK: - --------------------接口API--------------------
    
    // MARK: - 获取设备版本号
    class func iOSVersion() -> String {
        return UIDevice.currentDevice().systemVersion;
    }

    // MARK: - 获取设备型号
    class func deviceName() -> String {
        return UIDevice.currentDevice().systemName;
    }
    
    // MARK: - 获取App Version
    class func appVersion() -> String {
        let infoDict: NSDictionary = NSBundle.mainBundle().infoDictionary!
        return infoDict.objectForKey("CFBundleShortVersionString") as! String
    }

    // MARK: - 获取App Build
    class func appBuild() -> String {
        let infoDict: NSDictionary = NSBundle.mainBundle().infoDictionary!
        return infoDict.objectForKey("CFBundleVersion") as! String
    }


    // MARK: - 获取设备宽和高
    class func deviceWidth() -> CGFloat {
        return UIScreen.mainScreen().bounds.size.width
    }
    
    class func deviceHeight() -> CGFloat {
        return UIScreen.mainScreen().bounds.size.height
    }

}

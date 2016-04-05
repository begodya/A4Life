//
//  String.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 9/30/15.
//  Copyright © 2015 BooYah. All rights reserved.
//

import UIKit

extension String {
    
    // MARK: - 获取字符串的长度
    func size() -> Int {
        return self.characters.count
    }
    
    // MARK: - 类型转换
    func floatValue() -> Float {
        return (self as NSString).floatValue
    }
    
    func intValue() -> Int {
        return (self as NSString).integerValue
    }
    
    func doubleValue() -> Double {
        return (self as NSString).doubleValue
    }
    
    var encodingdata: NSData {
        return self.dataUsingEncoding(NSUTF8StringEncoding)!
    }
}

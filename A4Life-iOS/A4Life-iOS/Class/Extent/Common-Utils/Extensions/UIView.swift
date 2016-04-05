//
//  UIView.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 10/23/15.
//  Copyright © 2015 BooYah. All rights reserved.
//

import UIKit

extension UIView {
    // MARK: 局部代码分隔
    func local(closure: ()->()) {
        closure()
    }

    // MARK: 获取和设置x坐标
    func viewX() -> CGFloat {
        return self.frame.origin.x
    }
    
    func setViewX(x: CGFloat) {
        var frame: CGRect = self.frame
        frame.origin.x = x
        self.frame = frame
    }
    
    // MARK: 获取和设置y坐标
    func viewY() -> CGFloat {
        return self.frame.origin.y
    }
    
    func setViewY(y: CGFloat) {
        var frame: CGRect = self.frame
        frame.origin.y = y
        self.frame = frame
    }
    
    // MARK: 获取和设置width
    func viewWidth() -> CGFloat {
        return self.frame.size.width
    }
    
    func setViewWidth(width: CGFloat) {
        var frame: CGRect = self.frame
        frame.size.width = width
        self.frame = frame
    }
    
    // MARK: 获取和设置height
    func viewHeight() -> CGFloat {
        return self.frame.size.height
    }
    
    func setViewHeight(height: CGFloat) {
        var frame: CGRect = self.frame
        frame.size.height = height
        self.frame = frame
    }
}


//
//  BBRootView.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 10/8/15.
//  Copyright © 2015 BooYah. All rights reserved.
//

import UIKit

class BBRootView: UIView, BBFullScreenMaskViewDelegate {

    private var applicationWindow_: UIWindow!
    private var maskView_: BBFullScreenMaskView!
    
    // MARK: - --------------------System--------------------
    override func awakeFromNib() {
        super.awakeFromNib()
        
        applicationWindow_ = (UIApplication.sharedApplication().delegate?.window)!
    }
    
    // MARK: - --------------------功能函数--------------------
    // MARK: 初始化
    
    // MARK: - --------------------手势事件--------------------
    // MARK: 各种手势处理函数注释
    
    // MARK: - --------------------按钮事件--------------------
    // MARK: 按钮点击函数注释
    
    // MARK: - --------------------代理方法--------------------

    // MARK: BBFullScreenMaskViewDelegate
    func maskViewwillRemoveFromSuperView(maskView: BBFullScreenMaskView, superView: UIView) {
        maskView_ = nil
    }
    
    // MARK: - --------------------属性相关--------------------
    // MARK: 属性操作函数注释
    
    // MARK: - --------------------接口API--------------------
        
    // MARK: 通过XIB获取视图对象
    class func getViewFromXib(xibName: String) -> UIView {
        return getViewFromXib(xibName, index: 0)
    }
    
    // MARK: 通过XIB和index获取视图对象
    class func getViewFromXib(xibName: String, index: NSInteger) -> UIView {
        let array = NSBundle.mainBundle().loadNibNamed(xibName, owner: self, options: nil)
        var view: UIView!
        if (array.count > index) {
            view = array[index] as! UIView
        }
        
        return view
    }

    // MARK: 添加遮盖层
    func showCoverViewWithContentView(contentView: UIView, alpha: CGFloat) {
        self.showCoverViewWithContentView(contentView, isHideWhenTouchBackground: true, backgroundAlpha: alpha)
    }
    
    func showCoverViewWithContentView(contentView: UIView, isHideWhenTouchBackground: Bool, backgroundAlpha: CGFloat) {
        if (maskView_ == nil) {
            maskView_ = UIView.init(frame: (applicationWindow_?.bounds)!) as! BBFullScreenMaskView
            maskView_.delegate = self
            maskView_.alpha = 0.0
            maskView_.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(backgroundAlpha)
        }
        contentView.center = CGPointMake(maskView_.bounds.size.width/2.0, maskView_.bounds.size.height/2.0)
        maskView_.isHideWhenTouchBackground = isHideWhenTouchBackground
        maskView_.addSubview(contentView)
        applicationWindow_.addSubview(maskView_)
        
        UIView.animateWithDuration(0.5) { () -> Void in
            self.maskView_.alpha = 1.0
        }
    }

    // MARK: 隐藏遮盖层
    func hideMask() {
        self.maskView_.hideMaskView()
    }
}

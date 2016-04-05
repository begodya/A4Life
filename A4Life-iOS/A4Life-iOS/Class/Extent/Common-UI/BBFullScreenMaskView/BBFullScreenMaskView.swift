//
//  BBFullScreenMaskView.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 10/29/15.
//  Copyright © 2015 BooYah. All rights reserved.
//

import UIKit

protocol BBFullScreenMaskViewDelegate {
    func maskViewwillRemoveFromSuperView(maskView: BBFullScreenMaskView, superView: UIView)
}

class BBFullScreenMaskView: BBRootView {

    var delegate: BBFullScreenMaskViewDelegate?
    var isHideWhenTouchBackground: Bool = true
    // MARK: - --------------------System--------------------
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - --------------------功能函数--------------------
    // MARK: 初始化
    
    // MARK: - --------------------手势事件--------------------
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if self.isHideWhenTouchBackground {
            self.hideMaskView()
        }
    }
    
    // MARK: - --------------------按钮事件--------------------
    // MARK: 按钮点击函数注释
    
    // MARK: - --------------------代理方法--------------------
    // MARK: - 代理种类注释
    // MARK: 代理函数注释
    
    // MARK: - --------------------属性相关--------------------
    // MARK: 属性操作函数注释
    
    // MARK: - --------------------接口API--------------------

    func hideMaskView() {
        if (delegate != nil) {
            delegate?.maskViewwillRemoveFromSuperView(self, superView: self.superview!)
        }

        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.alpha = 0.0
            }) { (Bool) -> Void in
            self.removeFromSuperview()
        }
    }

}

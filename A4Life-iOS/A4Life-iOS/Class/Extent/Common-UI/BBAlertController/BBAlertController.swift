//
//  BBAlertController.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 10/8/15.
//  Copyright © 2015 BooYah. All rights reserved.
//

import UIKit

class BBAlertController: UIAlertController {

    // MARK: - --------------------System--------------------
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - --------------------功能函数--------------------
    
    // MARK: - --------------------手势事件--------------------
    // MARK: 各种手势处理函数注释
    
    // MARK: - --------------------按钮事件--------------------
    // MARK: 按钮点击函数注释
    
    // MARK: - --------------------代理方法--------------------
    // MARK: - 代理种类注释
    // MARK: 代理函数注释
    
    // MARK: - --------------------属性相关--------------------
    // MARK: 属性操作函数注释
    
    // MARK: - --------------------接口API--------------------

    /**
    *  显示提示信息，内容格式为：提示信息 + 内容 + 知道了
    *  @param message              内容体
    *  @return                     初始化好的弹出框
    */
    class func initWithMessage(message: String) -> BBAlertController {
        let alertAction = UIAlertAction(title: "好的", style: UIAlertActionStyle.Default, handler: nil)
        return self.initWithTitle("", message: message, alertAction: alertAction)
    }

    /**
    *  显示提示信息，内容格式为：提示信息 + 内容 + 知道了
    *  @param clickedAction        点击事件
    *  @param message              内容体
    *  @return                     初始化好的弹出框
    */
    class func initWithTitle(title: String, message: String, alertAction: UIAlertAction) -> BBAlertController {
        let alertController = BBAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(alertAction)
        return alertController
    }
    
    /**
    *  两个按钮响应操作
    *  @param title                标题
    *  @param message              信息
    *  @param cancalAction         取消按钮的动作
    *  @param otherAction          其他的按钮的动作
    *  @return                     初始化好的弹出框
    */
    class func initWithTitle(title: String, message: String, okAction: UIAlertAction, cancelAction: UIAlertAction) -> BBAlertController {
        let alertController = BBAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        return alertController
    }

}

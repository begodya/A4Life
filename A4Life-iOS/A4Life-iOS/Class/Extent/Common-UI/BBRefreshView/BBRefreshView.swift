//
//  BBRefreshView.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 10/29/15.
//  Copyright © 2015 BooYah. All rights reserved.
//

import UIKit

class BBRefreshView: BBRootView {

    @IBOutlet weak var refreshImageView: UIImageView!
    // MARK: - --------------------System--------------------
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = BBColor.defaultColor()
        
        self.refreshImageView?.image = GIFImage.imageWithName("Loading.gif", delegate: self.refreshImageView)
    }
    // MARK: - --------------------功能函数--------------------
    // MARK: 初始化
    
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
    // MARK: 分块内接口函数注释

}

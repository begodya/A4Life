//
//  BBH5WebView.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 10/13/15.
//  Copyright © 2015 BooYah. All rights reserved.
//

import UIKit

class BBH5WebView: UIWebView {
    
    // MARK: - --------------------System--------------------
    
    // MARK: - --------------------功能函数--------------------
    // MARK: 初始化
    
    // MARK: - --------------------手势事件--------------------
    // MARK: 各种手势处理函数注释
    
    // MARK: - --------------------按钮事件--------------------
    // MARK: 按钮点击函数注释
    
    // MARK: - --------------------代理方法--------------------
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if (self.delegate!.respondsToSelector(Selector("webView: request: navigationType:"))) {
            return self.delegate!.webView!(webView, shouldStartLoadWithRequest: request, navigationType: navigationType)
        }
        
        return true
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        if (self.delegate!.respondsToSelector(Selector("webViewDidStartLoad:"))) {
            self.delegate!.webViewDidFinishLoad!(webView)
        }
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        if (self.delegate!.respondsToSelector(Selector("webViewDidFinishLoad:"))) {
            self.delegate!.webViewDidFinishLoad!(webView)
        }
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        if (self.delegate!.respondsToSelector(Selector("webView: didFailLoadWithError:"))) {
            self.delegate!.webView!(webView, didFailLoadWithError: error)
        }
    }
    
    // MARK: - --------------------属性相关--------------------
    // MARK: 属性操作函数注释
    
    // MARK: - --------------------接口API--------------------
    // MARK: 分块内接口函数注释

}

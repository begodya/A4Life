//
//  BBH5ViewController.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 10/13/15.
//  Copyright © 2015 BooYah. All rights reserved.
//

import UIKit

class BBH5ViewController: BBRootViewController, UIWebViewDelegate {
    
    var h5WebView: BBH5WebView!
    
    // MARK: - --------------------System--------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        BBLoadingView.dismiss()
    }
    
    // MARK: - --------------------功能函数--------------------
    private func initWithURL(url: NSURL) -> BBH5ViewController {
        h5WebView = BBH5WebView(frame:CGRectMake(0, 0, BBDevice.deviceWidth(), BBDevice.deviceHeight()))
        local { () -> () in
            self.h5WebView.autoresizesSubviews = true
            self.h5WebView.scalesPageToFit = true
            self.h5WebView.loadRequest(NSURLRequest(URL: url))
            self.h5WebView.delegate = self
            
            self.view.addSubview(self.h5WebView)
        }
        
        return self;
    }
    
    // MARK: - --------------------手势事件--------------------
    // MARK: 各种手势处理函数注释
    
    // MARK: - --------------------按钮事件--------------------
    // MARK: 按钮点击函数注释
    
    // MARK: - --------------------代理方法--------------------
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        return true
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        BBLoadingView.setGif("Loading.gif")
        BBLoadingView.show()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        self.setCustomTitle(webView.stringByEvaluatingJavaScriptFromString("document.title")!)
        BBLoadingView.dismiss()
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        BBLoadingView.dismiss()
    }

    
    // MARK: - --------------------属性相关--------------------
    // MARK: 属性操作函数注释
    
    // MARK: - --------------------接口API--------------------
    
    /**
    加载URL
    
    - parameter url:                页面的URL地址
    - parameter fromViewController: 来自VC
    */
    func loadURL(url: NSURL, fromViewController: BBRootViewController) {
        loadURL(url, title: "", fromViewController: fromViewController)
    }

    /**
    加载URL
    
    - parameter url:                页面的URL地址
    - parameter title:              页面标题
    - parameter fromViewController: 来自VC
    */
    func loadURL(url: NSURL, title: String, fromViewController: BBRootViewController) {
        self.setCustomTitle(title)
        self.initWithURL(url)
        fromViewController.navigationController?.pushViewController(self, animated: true)
    }
}

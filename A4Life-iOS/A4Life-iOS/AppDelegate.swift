//
//  AppDelegate.swift
//  A4Life-iOS
//
//  Created by Bei Wang on 4/5/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        // 1、Init Data Source
        initDataSource()
        // 2、Register Notification
        registerNotification()
        // 3、Set up start view controller
        setupStartViewController()

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK: APNS
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        var token = deviceToken.description.stringByReplacingOccurrencesOfString("<", withString: "")
        token = token.stringByReplacingOccurrencesOfString(">", withString: "")
        AFLDataSource.setDeviceToken(token)
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        let token = "eb51381f 775241e1 eed0b011 c85122f2 eefef75c e478f2e7 f4ddb363 171f0cdet";
        AFLDataSource.setDeviceToken(token)
    }
    
    // MARK: - --------------------功能函数--------------------
    // MARK: 初始化
    private func initDataSource() {
        AFLDataSource.initDataSource()
        
        setupNavigationBarAppearance()
    }
    
    private func setupNavigationBarAppearance() {
//        let appearance = UINavigationBar.appearance()
//        appearance.titleTextAttributes = [
//            NSFontAttributeName: UIFont(name: "TrendSansOne", size: 20)!,
//            NSForegroundColorAttributeName: BBColor.titleColor()
//        ]
    }
    
    private func registerNotification() {
        UIApplication.sharedApplication().registerForRemoteNotifications()
        UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: UIUserNotificationType.Badge, categories: nil))
    }
    
    private func setupStartViewController() {
        self.window!.rootViewController = BBNavigationController(rootViewController: AFLHomeViewController())
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.makeKeyAndVisible()
    }
    
    // MARK: - --------------------手势事件--------------------
    // MARK: 各种手势处理函数注释
    
    // MARK: - --------------------按钮事件--------------------
    // MARK: 按钮点击函数注释
    
    // MARK: - --------------------代理方法--------------------
    // MARK: - 代理种类注释
    // MARK: 代理函数注释
    
    // MARK: - --------------------属性相关--------------------
    
    // MARK: - --------------------接口API--------------------
}


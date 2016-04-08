//
//  BBNavigationController.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 10/14/15.
//  Copyright © 2015 BooYah. All rights reserved.
//

import UIKit

private let kGuestureViewTag: Int! = 0xae42

class BBNavigationController: UINavigationController, UIGestureRecognizerDelegate {

    // Enable the drag to back interaction, Default is YES.
    var canDragBack: Bool = true
    
    private var startTouch: CGPoint?
    private var animateTime: NSTimeInterval = 0.3
    private var dragAnimated: Bool = true
    
    private var lastScreenShotView: UIImageView?
    private var backgroundView: UIView?
    private var screenShotsList: NSMutableArray! = NSMutableArray.init(capacity: 2)
    private var isMoving: Bool = true
    private var toViewController: UIViewController?
    private var shadowLayer: CAGradientLayer?
    
    // MARK: - --------------------System--------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Enable gesture recognizers
//        if (self.respondsToSelector(Selector("interactivePopGestureRecognizer"))) {
//            self.interactivePopGestureRecognizer?.delegate = self
//        }
        

        let panGesture: UIPanGestureRecognizer = UIPanGestureRecognizer.init(target: self, action: #selector(BBNavigationController.paningGestureReceive(_:)))
        panGesture.delaysTouchesBegan = true
        let gestureView: UIView = UIView.init(frame: CGRectMake(0, 64, 15, self.view.bounds.size.height))
        gestureView.addGestureRecognizer(panGesture)
        gestureView.tag = kGuestureViewTag
        self.view.addSubview(gestureView)
    }

    // MARK: - --------------------功能函数--------------------
    // MARK: 初始化
    
    // override the pop method
    override func popViewControllerAnimated(animated: Bool) -> UIViewController {
        self.removeLastImage()
        
        var animated: Bool = animated
        if (self.dragAnimated == true) {
            animated = false
        }
        
        let ctr: UIViewController = super.popViewControllerAnimated(animated)!
        return ctr
    }
    
    func removeLastImage() {
        let lastObj = (self.screenShotsList?.lastObject)! as! UIImage
        if (self.screenShotsList?.count > 1) {
            self.screenShotsList?.removeObject(lastObj)
        }
    }

    func restorePopAction() {
        self.shadowLayer?.removeFromSuperlayer()
        UIView.animateWithDuration(animateTime, animations: { () -> Void in
            self.moveViewWithX(0, isTransaction: false)
            }) { (Bool) -> Void in
                self.isMoving = false
                self.lastScreenShotView?.removeFromSuperview()
                self.lastScreenShotView = nil
        }
    }
    
    // override the push method
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        let capturedImg: UIImage? = self.captureSnapShot()
        if (capturedImg != nil) {
            self.screenShotsList?.addObject(capturedImg!)
        }
        self.canDragBack = true
        self.dragAnimated = false
        viewController.hidesBottomBarWhenPushed = true
        // fix 'nested pop animation can result in corrupted navigation bar'
        if (self.respondsToSelector(Selector("interactivePopGestureRecognizer"))) {
            self.interactivePopGestureRecognizer?.enabled = false
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    
    // get the current view screen shot
    func captureSnapShot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, self.view.opaque, 0.0);
        self.view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let img: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return img;
    }
    
    func addBackgroundMaskView() {
        let frame: CGRect = self.view.bounds
        if (self.backgroundView == nil) {
            self.backgroundView = UIView.init(frame: frame)
            self.view.superview!.insertSubview(self.backgroundView!, belowSubview: self.view)
        }
        
        self.backgroundView?.hidden = false
        if (self.lastScreenShotView == nil) {
            self.lastScreenShotView = UIImageView.init(frame: frame)
            self.backgroundView?.addSubview(self.lastScreenShotView!)
            self.shadowLayer = CAGradientLayer.init()
            self.shadowLayer?.startPoint = CGPointMake(1.0, 0.5)
            self.shadowLayer?.frame = frame
            self.shadowLayer?.endPoint = CGPointMake(0, 0.5)
            self.shadowLayer?.colors = NSArray(objects:UIColor.init(white: 0.0, alpha: 0.2).CGColor, UIColor.clearColor().CGColor) as [AnyObject]
            self.backgroundView?.layer.addSublayer(self.shadowLayer!)
        }
        
        if (self.screenShotsList?.count > 0) {
            self.lastScreenShotView?.image = (self.screenShotsList?.lastObject as! UIImage)
        }
    }
    
    func addShadowLayerIfNeed() {
        if ((self.backgroundView?.layer.sublayers?.contains(self.shadowLayer!)) != nil) {
            return
        }
        
        self.backgroundView?.layer.addSublayer(self.shadowLayer!)
    }
    
    // set lastScreenShotView 's position and alpha when paning
    func moveViewWithX(x: CGFloat, isTransaction: Bool) {
        var offsetX: CGFloat = x
        if (offsetX > self.view.bounds.size.width) {
            offsetX = self.view.bounds.size.width
        }
        if (offsetX < 0) {
            offsetX = 0
        }
        
        if (isTransaction) {
            CATransaction.begin()
            CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        }
        
        var frame: CGRect = self.view.frame
        frame.origin.x = x
        self.view.frame = frame
        self.lastScreenShotView!.center = CGPointMake(x/2, self.view.center.y);
        
        let shadowWidth: CGFloat = 10
        if (BBDevice.iOSVersion().floatValue() < 7.0) {
            self.shadowLayer!.frame = CGRectMake(x-shadowWidth, 20, shadowWidth, self.shadowLayer!.frame.size.height);
        } else {
            self.shadowLayer!.frame = CGRectMake(x-shadowWidth, 0, shadowWidth, self.shadowLayer!.frame.size.height);
        }

        if (isTransaction) {
            CATransaction.commit()
        }
        
    }
    
    func shouldInvokeCTRootBackItem() -> Bool {
        let tmpViewCtr: BBRootViewController = self.visibleViewController as! BBRootViewController
        var isUseCTRootBackItem: Bool = false
        
        if (tmpViewCtr.isKindOfClass(BBRootViewController) && !tmpViewCtr.isKindOfClass(BBH5ViewController)) {
            let backItem: UIBarButtonItem = (self.visibleViewController?.navigationItem.leftBarButtonItem)!
            let backBtn: UIButton = backItem.customView as! UIButton
            if (backBtn.isKindOfClass(UIButton)) {
                let targets: NSSet = backBtn.allTargets()
                for target in targets {
                    let actions: NSArray = backBtn.actionsForTarget(target, forControlEvent: UIControlEvents.TouchUpInside)!
                    for actionName in actions {
                        let selector: Selector = NSSelectorFromString(actionName as! String)
                        if selector != nil {
                            isUseCTRootBackItem = true

                        }
                    }
                }
            }
        }
        
        return isUseCTRootBackItem;
    }
    
    func shouldCancelDragAction() -> Bool {
        return false
    }

    // MARK: - --------------------手势事件--------------------
    // MARK: 各种手势处理函数注释
    
    // MARK: - --------------------按钮事件--------------------
    // MARK: 按钮点击函数注释
    
    // MARK: - --------------------代理方法--------------------

    // MARK: Gesture Recognizer -
    func paningGestureReceive(recoginzer: UIPanGestureRecognizer) {
    
        if (self.viewControllers.count <= 1 || !self.canDragBack) {
            return;
        }
        
        let touchPoint: CGPoint = recoginzer.locationInView(UIApplication.sharedApplication().keyWindow)
        if (recoginzer.state == UIGestureRecognizerState.Began) {
            self.view.userInteractionEnabled = false
            self.isMoving = true
            self.startTouch = touchPoint
            self.addBackgroundMaskView()
            
        } else if (recoginzer.state == UIGestureRecognizerState.Ended) {
            self.view.userInteractionEnabled = true
            let velocityX: CGFloat = recoginzer.velocityInView(self.view).x
            if (velocityX < 200) {
                animateTime = 0.3;
            } else {
                animateTime = 0.2;
            }
            
            if (touchPoint.x - startTouch!.x > self.view.frame.size.width/3) {
                let x: CGFloat = self.view.frame.size.width
                self.addShadowLayerIfNeed()
                
                
                UIView.animateWithDuration(animateTime, animations: { () -> Void in
                    self.moveViewWithX(x, isTransaction: false)

                    }, completion: { (Bool) -> Void in
                        var frame: CGRect = self.view.frame
                        frame.origin.x = 0;
                        self.view.frame = frame;
                        
                        self.dragAnimated = true;
                        
//                        if (!self.shouldInvokeCTRootBackItem()) {
                            self.popViewControllerAnimated(false)
                            
//                        }
                        
                        self.dragAnimated = false;
                        
                        self.isMoving = false;
                })
                
            } else {
                self.restorePopAction()
            }
            return
            
        } else if (recoginzer.state == UIGestureRecognizerState.Cancelled) {
            self.view.userInteractionEnabled = true;
            self.restorePopAction()
            return
            
        } else {
            if (self.isMoving) {
                if (touchPoint.x - startTouch!.x > (self.view.frame.size.width/6)) {
                    if (self.shouldCancelDragAction()) {
                        return
                    }
                }
                
                self.addShadowLayerIfNeed()
                self.moveViewWithX(touchPoint.x - startTouch!.x, isTransaction: true)
            }
        }

    }
    
    // MARK: - --------------------属性相关--------------------
    // MARK: 属性操作函数注释
    
    // MARK: - --------------------接口API--------------------
    // MARK: 分块内接口函数注释

}

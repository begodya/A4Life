//
//  BBLoadingView.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 10/14/15.
//  Copyright © 2015 BooYah. All rights reserved.
//

import UIKit

class BBLoadingView: BBRootView {
    
    // MARK: Constants
    let Size            : CGFloat           = 150
    let FadeDuration    : NSTimeInterval    = 0.3
    let GifSpeed        : CGFloat           = 0.3
    let OverlayAlpha    : CGFloat           = 0.3
    let Window          : UIWindow = (UIApplication.sharedApplication().delegate as! AppDelegate).window!
    
    
    // MARK: Variables
    var overlayView     : UIView?
    var imageView       : UIImageView?
    var shown           : Bool
    private var tapGesture: UITapGestureRecognizer?
    private var didTapClosure: (() -> Void)?
    private var swipeGesture: UISwipeGestureRecognizer?
    private var didSwipeClosure: (() -> Void)?

    // MARK: - --------------------System--------------------
    
    // MARK: Init
    init () {
        self.shown = false
        super.init(frame: CGRect (x: 0, y: 0, width: Size, height: Size))
        
        alpha = 0
        center = Window.center
        clipsToBounds = false
        layer.backgroundColor = UIColor (white: 0, alpha: 0.5).CGColor
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        imageView = UIImageView (frame: CGRectInset(bounds, 20, 20))
        addSubview(imageView!)
        
        Window.addSubview(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: - --------------------功能函数--------------------
    
    // MARK: Singleton
    class var sharedInstance : BBLoadingView {
        struct Static {
            static let instance : BBLoadingView = BBLoadingView()
        }
        return Static.instance
    }
    
    // MARK: - --------------------手势事件--------------------
    // MARK: 各种手势处理函数注释
    
    // MARK: - --------------------按钮事件--------------------
    // MARK: 按钮点击函数注释
    
    @objc private class func userTapped () {
        BBLoadingView.dismiss()
        self.sharedInstance.tapGesture = nil
        self.sharedInstance.didTapClosure?()
        self.sharedInstance.didTapClosure = nil
    }
    
    @objc private class func userSwiped () {
        BBLoadingView.dismiss()
        self.sharedInstance.swipeGesture = nil
        self.sharedInstance.didSwipeClosure?()
        self.sharedInstance.didSwipeClosure = nil
    }

    
    // MARK: - --------------------代理方法--------------------
    // MARK: - 代理种类注释
    // MARK: 代理函数注释
    
    // MARK: - --------------------属性相关--------------------
    // MARK: 属性操作函数注释
    
    // MARK: Effects
    
    func fadeIn () {
        imageView?.startAnimatingGif()
        UIView.animateWithDuration(FadeDuration, animations: {
            self.alpha = 1
        })
    }
    
    func fadeOut () {
        UIView.animateWithDuration(FadeDuration, animations: { () -> Void in
            self.alpha = 0
            }) { (Bool) -> Void in
                self.shown = false
                self.imageView?.stopAnimatingGif()
        }
    }
    
    func fadeOut (completed: ()->Void) {
        UIView.animateWithDuration(FadeDuration, animations: { () -> Void in
            self.alpha = 0
            }) { (Bool) -> Void in
                self.shown = false
                self.imageView?.stopAnimatingGif()
                completed ()
        }
    }
    
    func overlay () -> UIView {
        if (overlayView == nil) {
            overlayView = UIView (frame: Window.frame)
            overlayView?.backgroundColor = UIColor.blackColor()
            overlayView?.alpha = 0
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.overlayView!.alpha = self.OverlayAlpha
            })
        }
        
        return overlayView!
    }
    
    // MARK: - --------------------接口API--------------------
    // MARK: 分块内接口函数注释
    
    class func showWithOverlay () {
        dismiss ({
            self.sharedInstance.Window.addSubview(self.sharedInstance.overlay())
            self.show()
        })
    }
    
    class func show () {
        dismiss({
            
            if let _ = self.sharedInstance.imageView?.animationImages {
                self.sharedInstance.imageView?.startAnimating()
            } else {
                self.sharedInstance.imageView?.startAnimatingGif()
            }
            
            self.sharedInstance.Window.bringSubviewToFront(self.sharedInstance)
            self.sharedInstance.shown = true
            self.sharedInstance.fadeIn()
        })
    }
    
    class func showForSeconds (seconds: Double) {
        show()
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(seconds * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue(), {
            BBLoadingView.dismiss()
        })
    }
    
    class func dismissOnTap (didTap: (() -> Void)? = nil) {
        self.sharedInstance.tapGesture = UITapGestureRecognizer(target: self, action: "userTapped")
        self.sharedInstance.addGestureRecognizer(self.sharedInstance.tapGesture!)
        self.sharedInstance.didTapClosure = didTap
    }
    
    class func dismissOnSwipe (didTap: (() -> Void)? = nil) {
        self.sharedInstance.swipeGesture = UISwipeGestureRecognizer(target: self, action: "userSwiped")
        self.sharedInstance.addGestureRecognizer(self.sharedInstance.swipeGesture!)
    }
    
    class func dismiss () {
        if (!self.sharedInstance.shown) {
            return
        }
        
        self.sharedInstance.overlay().removeFromSuperview()
        self.sharedInstance.fadeOut()
        
        if let _ = self.sharedInstance.imageView?.animationImages {
            self.sharedInstance.imageView?.stopAnimating()
        } else {
            self.sharedInstance.imageView?.stopAnimatingGif()
        }
    }
    
    class func dismiss (complete: ()->Void) {
        if (!self.sharedInstance.shown) {
            return complete ()
        }
        
        self.sharedInstance.fadeOut({
            self.sharedInstance.overlay().removeFromSuperview()
            complete ()
        })
        
        if let _ = self.sharedInstance.imageView?.animationImages {
            self.sharedInstance.imageView?.stopAnimating()
        } else {
            self.sharedInstance.imageView?.stopAnimatingGif()
        }
    }
    
    
    
    
    // MARK: Gif
    
    class func setGif (name: String) {
        self.sharedInstance.imageView?.animationImages = nil
        self.sharedInstance.imageView?.stopAnimating()
        
        self.sharedInstance.imageView?.image = GIFImage.imageWithName(name, delegate: self.sharedInstance.imageView)
    }
    
    class func setGifBundle (bundle: NSBundle) {
        self.sharedInstance.imageView?.animationImages = nil
        self.sharedInstance.imageView?.stopAnimating()
        
        self.sharedInstance.imageView?.image = GIFImage (data: NSData(contentsOfURL: bundle.resourceURL!)!, delegate: nil)
    }
    
    class func setGifImages (images: [UIImage]) {
        self.sharedInstance.imageView?.stopAnimatingGif()
        
        self.sharedInstance.imageView?.animationImages = images
        self.sharedInstance.imageView?.animationDuration = NSTimeInterval(self.sharedInstance.GifSpeed)
    }

}

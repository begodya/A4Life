//
//  GIFImage.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 10/14/15.
//  Copyright © 2015 BooYah. All rights reserved.
//

import UIKit
import ImageIO
import MobileCoreServices

extension UIImageView {
    
    // MARK: Computed Properties
    
    var animatableImage: GIFImage? {
        if image is GIFImage {
            return image as? GIFImage
        } else {
            return nil
        }
    }
    
    var isAnimatingGif: Bool {
        return animatableImage?.isAnimating() ?? false
    }
    
    var animatable: Bool {
        return animatableImage != nil
    }
    
    
    // MARK: Method Overrides
    
    override public func displayLayer(layer: CALayer) {
        if let image = animatableImage {
            if let frame = image.currentFrame {
                layer.contents = frame.CGImage
            }
        }
    }
    
    
    // MARK: Setter Methods
    
    func setAnimatableImage(named name: String) {
        image = GIFImage.imageWithName(name, delegate: self)
        layer.setNeedsDisplay()
    }
    
    func setAnimatableImage(data data: NSData) {
        image = GIFImage.imageWithData(data, delegate: self)
        layer.setNeedsDisplay()
    }
    
    
    // MARK: Animation
    
    func startAnimatingGif() {
        if animatable {
            animatableImage!.resumeAnimation()
        }
    }
    
    func stopAnimatingGif() {
        if animatable {
            animatableImage!.pauseAnimation()
        }
    }
    
}


class GIFImage: UIImage {
    
    func CGImageSourceContainsAnimatedGIF(imageSource: CGImageSource) -> Bool {
        let isTypeGIF = UTTypeConformsTo(CGImageSourceGetType(imageSource)!, kUTTypeGIF)
        let imageCount = CGImageSourceGetCount(imageSource)
        return isTypeGIF != false && imageCount > 1
    }
    
    func CGImageSourceGIFFrameDuration(imageSource: CGImageSource, index: Int) -> NSTimeInterval {
        let containsAnimatedGIF = CGImageSourceContainsAnimatedGIF(imageSource)
        if !containsAnimatedGIF { return 0.0 }
        
        var duration = 0.0
        let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, Int(index), nil)! as Dictionary
        let GIFProperties: NSDictionary? = imageProperties[String(kCGImagePropertyGIFDictionary)] as? NSDictionary
        
        if let properties = GIFProperties {
            duration = properties[String(kCGImagePropertyGIFUnclampedDelayTime)] as! Double
            
            if duration <= 0 {
                duration = properties[String(kCGImagePropertyGIFDelayTime)] as! Double
            }
        }
        
        let threshold = 0.02 - Double(FLT_EPSILON)
        
        if duration > 0 && duration < threshold {
            duration = 0.1
        }
        
        return duration
    }
    
    
    // MARK: Constants
    
    let framesToPreload = 10
    let maxTimeStep = 1.0
    
    
    // MARK: Public Properties
    
    var delegate: UIImageView?
    var frameDurations = [NSTimeInterval]()
    var frames = [UIImage?]()
    var totalDuration: NSTimeInterval = 0.0
    
    
    // MARK: Private Properties
    
    private lazy var displayLink: CADisplayLink = CADisplayLink(target: self, selector: "updateCurrentFrame")
    private lazy var preloadFrameQueue: dispatch_queue_t! = dispatch_queue_create("co.kaishin.GIFPreloadImages", DISPATCH_QUEUE_SERIAL)
    private var currentFrameIndex = 0
    private var imageSource: CGImageSource?
    private var timeSinceLastFrameChange: NSTimeInterval = 0.0
    
    
    // MARK: Computed Properties
    
    var currentFrame: UIImage? {
        return frameAtIndex(currentFrameIndex)
    }
    
    private var isAnimated: Bool {
        return imageSource != nil
    }
    
    
    // MARK: Initializers
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required init(data: NSData, delegate: UIImageView?) {
        let imageSource = CGImageSourceCreateWithData(data, nil)
        self.delegate = delegate
        
        super.init()
        attachDisplayLink()
        prepareFrames(imageSource)
        pauseAnimation()
    }

    required convenience init(imageLiteral name: String) {
        fatalError("init(imageLiteral:) has not been implemented")
    }
    
    // MARK: Factories
    
    class func imageWithName(name: String, delegate: UIImageView?) -> Self? {
        let path = (NSBundle.mainBundle().bundlePath as NSString).stringByAppendingPathComponent(name)
        let data = NSData (contentsOfFile: path)
        return (data != nil) ? imageWithData(data!, delegate: delegate) : nil
    }
    
    class func imageWithData(data: NSData, delegate: UIImageView?) -> Self? {
        return self.init(data: data, delegate: delegate)
    }
    
    
    // MARK: Display Link Helpers
    
    func attachDisplayLink() {
        displayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
    }
    
    
    // MARK: Frame Methods
    
    private func prepareFrames(source: CGImageSource!) {
        imageSource = source
        
        let numberOfFrames = Int(CGImageSourceGetCount(self.imageSource!))
        frameDurations.reserveCapacity(numberOfFrames)
        frames.reserveCapacity(numberOfFrames)
        
        for index in 0..<numberOfFrames {
            let frameDuration = CGImageSourceGIFFrameDuration(source, index: index)
            frameDurations.append(frameDuration)
            totalDuration += frameDuration
            
            if index < framesToPreload {
                let frameImageRef = CGImageSourceCreateImageAtIndex(self.imageSource!, Int(index), nil)
                let frame = UIImage(CGImage: frameImageRef!, scale: 0.0, orientation: UIImageOrientation.Up)
                frames.append(frame)
            } else {
                frames.append(nil)
            }
        }
    }
    
    func frameAtIndex(index: Int) -> UIImage? {
        if Int(index) >= self.frames.count { return nil }
        
        let image: UIImage? = self.frames[Int(index)]
        updatePreloadedFramesAtIndex(index)
        
        return image
    }
    
    private func updatePreloadedFramesAtIndex(index: Int) {
        if frames.count <= framesToPreload { return }
        
        if index != 0 {
            frames[index] = nil
        }
        
        for internalIndex in (index + 1)...(index + framesToPreload) {
            let adjustedIndex = internalIndex % frames.count
            
            if frames[adjustedIndex] == nil {
                dispatch_async(preloadFrameQueue) {
                    let frameImageRef = CGImageSourceCreateImageAtIndex(self.imageSource!, Int(adjustedIndex), nil)
                    self.frames[adjustedIndex] = UIImage(CGImage: frameImageRef!)
                }
            }
        }
    }
    
    func updateCurrentFrame() {
        if !isAnimated { return }
        
        timeSinceLastFrameChange += min(maxTimeStep, displayLink.duration)
        let frameDuration = frameDurations[currentFrameIndex]
        
        while timeSinceLastFrameChange >= frameDuration {
            timeSinceLastFrameChange -= frameDuration
            currentFrameIndex++
            
            if currentFrameIndex >= frames.count {
                currentFrameIndex = 0
            }
            
            delegate?.layer.setNeedsDisplay()
        }
    }
    
    
    // MARK: Animation
    
    func pauseAnimation() {
        displayLink.paused = true
    }
    
    func resumeAnimation() {
        displayLink.paused = false
    }
    
    func isAnimating() -> Bool {
        return !displayLink.paused
    }
}

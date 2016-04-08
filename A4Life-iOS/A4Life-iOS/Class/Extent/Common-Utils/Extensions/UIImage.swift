//
//  UIImage.swift
//  A4Life-iOS
//
//  Created by Bei Wang on 4/8/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

import UIKit

extension UIImage {
    
    func imageFromColor(color: UIColor) -> UIImage {
        let size: CGSize = CGSizeMake(1, 1)
        let bounds: CGRect = CGRectMake(0, 0, size.width, size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0);
        let context: CGContextRef = UIGraphicsGetCurrentContext()!
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, bounds);
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        return image;
    }
}


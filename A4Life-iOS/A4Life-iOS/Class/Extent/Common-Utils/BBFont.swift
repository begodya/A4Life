//
//  BBFont.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 9/30/15.
//  Copyright © 2015 BooYah. All rights reserved.
//

import UIKit

class BBFont: NSObject {
    
    // MARK: - --------------------功能函数--------------------
    
    
    // MARK: - --------------------接口API--------------------
    
    // MAKR: - set custom font size
    class func customFontWithSize(size: CGFloat) -> UIFont {
        return UIFont.systemFontOfSize(size)
    }

}

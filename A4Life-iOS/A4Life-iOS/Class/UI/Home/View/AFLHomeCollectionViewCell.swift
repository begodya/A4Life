//
//  AFLHomeCollectionViewCell.swift
//  A4Life-iOS
//
//  Created by Bei Wang on 4/6/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

import UIKit

class AFLHomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var itemLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.contentView.backgroundColor = UIColor.redColor()
        itemLabel.textColor = UIColor.whiteColor()
        itemLabel.backgroundColor = UIColor.blueColor()
        itemLabel.text = "1"
    }

}

//
//  BBTableViewCell.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 10/8/15.
//  Copyright © 2015 BooYah. All rights reserved.
//

import UIKit

enum eGroupTableViewCellPosition: Int {
    case None
    case Top       // section中居于顶部
    case Middle    // section中居于中间
    case Bottom    // section中居于底部
    case Single    // 单个cell的section
}


class BBTableViewCell: UITableViewCell {

    var separatorLength: CGFloat! = BBDevice.deviceWidth() - 15.0
    var separatorColor: UIColor! = BBColor.defaultColor()
    
    private var position: eGroupTableViewCellPosition = .None
    private var lineHeight: CGFloat = 0.5
    
    // MARK: - --------------------System--------------------
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    // MARK: - --------------------功能函数--------------------
    // MARK: 初始化
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        let separatorView: BBRootView = BBRootView.init(frame: CGRectMake(BBDevice.deviceWidth()-separatorLength, self.bounds.size.height-lineHeight, separatorLength, lineHeight))
        separatorView.backgroundColor = separatorColor
        switch self.position {
        case .Top:
            let topSeparatorView: BBRootView = BBRootView.init(frame: CGRectMake(0, 0.2, BBDevice.deviceWidth(), lineHeight))
            topSeparatorView.backgroundColor = separatorColor
            self.addSubview(topSeparatorView)
            break
        case .Middle:
            break
        case .Bottom:
            separatorView.setViewX(0)
            separatorView.setViewWidth(BBDevice.deviceWidth())
            break
        case .Single:
            break
        default:
            break
        }

        self.addSubview(separatorView)
    }

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
    
    func setGroupPositionForIndexPath(indexPath: NSIndexPath, tableView: UITableView) {
        let rowsInSection: NSInteger = tableView.numberOfRowsInSection(indexPath.section)
        let row = indexPath.row
        
        var position: eGroupTableViewCellPosition = .Bottom
        if row == 0 {
            position = .Top
        } else if (row < rowsInSection-1) {
            position = .Middle
        } else if (row == 1) {
            position = .Single
        }
        
        if self.position != position {
            self.position = position
        }
    }
    
    /**
    *  从XIB获取cell对象
    *
    *  @param xibName xib名称
    */
    class func cellFromXib(xibName: String) -> BBTableViewCell {
        let array = NSBundle.mainBundle().loadNibNamed(xibName, owner: nil, options: nil)
        var cell: BBTableViewCell!
        if (array.count > 0) {
            cell = array[0] as! BBTableViewCell
        }
        if (cell == nil) {
            cell = BBTableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
        }
        
        return cell;
    }
    
    /**
    *  从XIB获取第index个对象cell
    *
    *  @param xibName xib名称
    *  @param index 对象索引
    */
    class func cellFromXib(xibName: String, index: NSInteger) -> BBTableViewCell {
        let array = NSBundle.mainBundle().loadNibNamed(xibName, owner: nil, options: nil)
        var cell: BBTableViewCell!
        if (array.count > index) {
            cell = array[index] as! BBTableViewCell
        }
        if (cell == nil) {
            cell = BBTableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
        }
        
        return cell;
    }

    /**
    *  从XIB获取identifier对象cell
    *
    *  @param xibName xib名称
    *  @param identifier 对象标识
    */
    class func cellFromXib(xibName: String, identifier: String) -> BBTableViewCell {
        let array = NSBundle.mainBundle().loadNibNamed(xibName, owner: nil, options: nil)
        var cell: BBTableViewCell!
        for var i=0; i<array.count; ++i {
            let view = array[i]
            if ((view as? BBTableViewCell) != nil) {
                cell = view as! BBTableViewCell
            }
        }
        if (cell == nil) {
            cell = BBTableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
        }

        return cell
    }
    
}

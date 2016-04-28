//
//  AFLHomeViewController.swift
//  A4Life-iOS
//
//  Created by Bei Wang on 4/5/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

import UIKit

class AFLHomeViewController: BBRootViewController, UICollectionViewDelegate, UICollectionViewDataSource, AFLDateViewControllerDelegate {

    @IBOutlet weak var contentCollectionView: UICollectionView!
    @IBOutlet weak var contentLabel: UILabel!
    
    var birthYear: Int = 0
    
    // MARK: - --------------------System--------------------
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setCustomTitle("A4 Life")
        self.setRightBarButtonWithTitle("75", target: self, action: #selector(clickedYearButtonAction))
    
        self.contentCollectionView.backgroundColor = BBColor.defaultColor()
        self.contentCollectionView.registerClass(AFLHomeCollectionViewCell.self, forCellWithReuseIdentifier: "AFLHomeCollectionViewCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - --------------------功能函数--------------------
    
    func getCurrentYear() -> Int {
        let dateFormatter:NSDateFormatter = NSDateFormatter();
        dateFormatter.dateFormat = "yyyy/MM/dd";
        let dateString:String = dateFormatter.stringFromDate(NSDate());
        var dates:[String] = dateString.componentsSeparatedByString("/")
        return Int(dates[0])!
    }
    
    // MARK: - --------------------手势事件--------------------
    func clickedYearButtonAction() {
        self.showDatePage()
    }

    
    // MARK: - --------------------按钮事件--------------------
    // MARK: 按钮点击函数注释
    
    // MARK: - --------------------代理方法--------------------
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 900;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("AFLHomeCollectionViewCell", forIndexPath: indexPath) as! AFLHomeCollectionViewCell
        
        if indexPath.item <= (getCurrentYear()-birthYear)*12 {
            if indexPath.item <= 18*12 {
                cell.backgroundColor = UIColor.blueColor()
            } else if indexPath.item <= 22*12 {
                cell.backgroundColor = UIColor.purpleColor()
            } else if indexPath.item <= 30*12 {
                cell.backgroundColor = UIColor.orangeColor()
            } else if indexPath.item <= 40*12 {
                cell.backgroundColor = UIColor.magentaColor()
            } else if indexPath.item <= 50*12 {
                cell.backgroundColor = UIColor.brownColor()
            } else if indexPath.item <= 60*12 {
                cell.backgroundColor = UIColor.darkGrayColor()
            } else {
                cell.backgroundColor = UIColor.redColor()
            }

        } else {
            cell.backgroundColor = UIColor.whiteColor()
        }
        
        NSLog("%d", indexPath.row+1)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake((collectionView.contentSize.width-29)/30, (collectionView.contentSize.width-29)/30)
    }
    
    // AFLDateViewControllerDelegate
    func selectBirthYear(year: Int) {
        birthYear = year
        self.contentCollectionView.reloadData()
        
        var tip = ""
        if getCurrentYear()-birthYear <= 18 {
            tip = "青春，一旦和它紧紧地握手，就能获得开拓新途径的动力，拥有创造性人生的灵性。"
        } else if getCurrentYear()-birthYear <= 22 {
            tip = "成长的过程就是破茧为蝶，挣扎着褪掉所有的青涩和丑陋，在阳光下抖动轻盈美丽的翅膀，闪闪的，微微的，幸福的，颤抖。 "
        } else if getCurrentYear()-birthYear <= 30 {
            tip = "迈向而立之年"
        } else if getCurrentYear()-birthYear <= 40 {
            tip = "迈向不惑之年"
        } else if getCurrentYear()-birthYear <= 50 {
            tip = "迈向知天命之年 "
        } else if getCurrentYear()-birthYear <= 60 {
            tip = "迈向花甲之年"
        } else {
            tip = "人生苦短，能留下的就是最好的。"
        }
        
        let have = "\r\n已悄然迈过" + String((getCurrentYear()-birthYear)*12) + "格\n"
        let still = "还有" + String((900-(getCurrentYear()-birthYear)*12)) + "格"
        self.contentLabel.text = tip + have + still
    }

    // MARK: - --------------------属性相关--------------------
    
    // MARK: - --------------------接口API--------------------
    func showDatePage() {
        let datePage = AFLDateViewController()
        datePage.delegate = self
        self.navigationController?.pushViewController(datePage, animated: false)
    }

}

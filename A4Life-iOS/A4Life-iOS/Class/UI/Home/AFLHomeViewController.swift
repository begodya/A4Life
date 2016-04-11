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
    var birthYear: Int = 0
    
    // MARK: - --------------------System--------------------
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setCustomTitle("A4 Life")
        self.setRightBarButtonWithTitle("年份", target: self, action: #selector(clickedYearButtonAction))
    
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
                cell.backgroundColor = UIColor.orangeColor()
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
    }

    // MARK: - --------------------属性相关--------------------
    
    // MARK: - --------------------接口API--------------------
    func showDatePage() {
        let datePage = AFLDateViewController()
        datePage.delegate = self
        self.navigationController?.pushViewController(datePage, animated: false)
    }

}

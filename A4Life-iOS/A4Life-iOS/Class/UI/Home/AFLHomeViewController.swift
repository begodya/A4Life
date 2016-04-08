//
//  AFLHomeViewController.swift
//  A4Life-iOS
//
//  Created by Bei Wang on 4/5/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

import UIKit

class AFLHomeViewController: BBRootViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var contentCollectionView: UICollectionView!
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
        
        if indexPath.item <= 18*12 {
            cell.backgroundColor = UIColor.blueColor()
        } else if indexPath.item <= 22*12 {
            cell.backgroundColor = UIColor.orangeColor()
        } else if indexPath.item <= 28*12 {
            cell.backgroundColor = UIColor.redColor()
        } else {
            cell.backgroundColor = UIColor.whiteColor()
        }
        
        NSLog("%d", indexPath.row+1)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake((collectionView.contentSize.width-29)/30, (collectionView.contentSize.width-29)/30)
    }

    // MARK: - --------------------属性相关--------------------
    
    // MARK: - --------------------接口API--------------------
    func showDatePage() {
//        self.navigationController?.presentViewController(AFLDateViewController(), animated: false, completion: {
//            
//        })
        self.navigationController?.pushViewController(AFLDateViewController(), animated: false)
    }

}

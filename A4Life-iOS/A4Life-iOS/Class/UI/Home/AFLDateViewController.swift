//
//  AFLDateViewController.swift
//  A4Life-iOS
//
//  Created by Bei Wang on 4/8/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

import UIKit

class AFLDateViewController: BBRootViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var yearPicker: UIPickerView!
    @IBOutlet weak var pickerButton: UIButton!
    
    // MARK: - --------------------System--------------------
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.pickerButton.layer.cornerRadius = CGFloat(5)
        self.pickerButton.layer.masksToBounds = true
        self.pickerButton.setBackgroundImage(UIImage().imageFromColor(UIColor.grayColor()), forState: UIControlState.Normal)
        self.pickerButton.setBackgroundImage(UIImage().imageFromColor(UIColor.darkGrayColor()), forState: UIControlState.Highlighted)
        self.pickerButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.pickerButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Highlighted)
    
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - --------------------功能函数--------------------
    
    // MARK: - --------------------手势事件--------------------
    
    // MARK: - --------------------按钮事件--------------------
    
    @IBAction func clickedPickerButton(sender: AnyObject) {
        let okAction = UIAlertAction(title: "是的", style: UIAlertActionStyle.Default) { (handler) in
            self.navigationController?.popViewControllerAnimated(true)
        }
        let cancelAction = UIAlertAction(title: "放弃", style: UIAlertActionStyle.Default) { (handler) in
            
        }
        
        let alertController = BBAlertController.initWithTitle("", message: "您的出生年份为\(1942+self.yearPicker.selectedRowInComponent(0))", okAction: okAction, cancelAction: cancelAction)
        self.presentViewController(alertController, animated: true) {

        }
    }
    
    // MARK: - --------------------代理方法--------------------

    func numberOfComponentsInPickerView( pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(pickerView: UIPickerView,numberOfRowsInComponent component: Int) -> Int{
        return 75
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int)
        -> String? {
        return String(1942+row)
    }
    
    // MARK: - --------------------属性相关--------------------
    
    // MARK: - --------------------接口API--------------------

}

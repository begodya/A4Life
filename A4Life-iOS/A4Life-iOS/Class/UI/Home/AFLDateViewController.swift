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
    
    // MARK: - --------------------System--------------------
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - --------------------功能函数--------------------
    
    // MARK: - --------------------手势事件--------------------
    
    // MARK: - --------------------按钮事件--------------------
    
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

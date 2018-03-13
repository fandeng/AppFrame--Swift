//
//  HomeViewController.swift
//  AppFrame
//
//  Created by 樊登 on 2018/3/13.
//  Copyright © 2018年 樊登. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func clickAlertView(_ sender: Any) {
        let alertView:FDCustomAlertView = FDCustomAlertView.init(frame:UIScreen.main.bounds, title: "自定义提示框", message: "", confirmTitle: "确定", cancleTitle: "取消", isShowTop: true, topTitle:"标题")
        alertView.cancalColor = kThemeColor;
        alertView.topColor = kThemeColor;
        alertView.topTitleColor = UIColor.white;
        alertView.confirmTitleColor = UIColor.white;
        alertView.confirmColor = UIColor.red;
        alertView.cancalColor = UIColor.colorWithHexString(hex: "#eff5f7");
        alertView.cancalTitleColor = kMainColor;
        alertView.refreshView()
        alertView.customAlertViewClickAction = { (index,customalertView) ->() in
            print(index)
            customalertView.removeFromSuperview()
        }
        alertView.showCustomAlertView()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


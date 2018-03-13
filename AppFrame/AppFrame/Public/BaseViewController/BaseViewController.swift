//
//  BaseViewController.swift
//  AppFrame
//
//  Created by 樊登 on 2018/3/13.
//  Copyright © 2018年 樊登. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        edgesForExtendedLayout = .bottom
        
        automaticallyAdjustsScrollViewInsets = false;
        
        navigationController?.navigationBar.barTintColor = kThemeColor
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font:kNavFont, NSAttributedStringKey.foregroundColor:UIColor.white]
        
        navigationController?.navigationBar.tintColor = UIColor.white
        
        view.backgroundColor = UIColor.white
        
        //修改tabbar选中颜色
        tabBarController?.tabBar.tintColor = kThemeColor
        
        tabBarController?.tabBar.barTintColor = UIColor.white
    }
    
    open func createBackButton() {
        
        let leftItem = UIBarButtonItem(image: UIImage.init(named: "goback")!.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(clickBackButtonAction))
        
        self.navigationItem.leftBarButtonItem = leftItem
    }
    
    open func createRightButton(title:String, imgName:String) {
        
        if title.isEmpty {
            
            let rightItem = UIBarButtonItem(image: UIImage.init(named: imgName)!.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(clickRightButtonAction))
            
            self.navigationItem.rightBarButtonItem = rightItem
            
        } else {
            
            let rightItem = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(clickRightButtonAction))
            
            rightItem.setTitleTextAttributes([NSAttributedStringKey.font:kMainFont], for: .normal)
            
            rightItem.tintColor = UIColor.white
            
            self.navigationItem.rightBarButtonItem = rightItem
            
        }
    }
    
    // 隐藏导航条
    open func hideNavigationBar() {
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.barStyle = .blackOpaque
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
    }
    
    @objc open func clickRightButtonAction(){
        //由子类实现
    }
    
    @objc open func clickBackButtonAction(){
        self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

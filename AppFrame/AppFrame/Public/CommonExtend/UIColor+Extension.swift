//
//  UIColor+Extension.swift
//  TodayNews-Swift
//
//  Created by 杨蒙 on 2017/11/21.
//  Copyright © 2017年 杨蒙. All rights reserved.
//

import UIKit

extension UIColor {
    // 便利初始化方法
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    /// 背景灰色 f8f9f7
    class func globalBackgroundColor() -> UIColor {
        return UIColor(r: 248, g: 249, b: 247)
    }
    
    /// 背景蓝色 4CADFD
    class func globalBlueColor() -> UIColor {
        return UIColor(r: 76, g: 173, b: 253)
    }
    
    /// RGBA的颜色设置 D23F42
    func myColor(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
        return UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
    }
    
    /// 红色 D23F42 ，F55A5D （245, 90, 93）
    class func globalRedColor() -> UIColor {
        return UIColor(r: 210, g: 63, b: 66)
    }
    
    /// 随机颜色
    class func randomColor() -> UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
    
    class func colorWithHexString(hex:String) ->UIColor {
        
        let colorString: String = hex.replacingOccurrences(of: "#", with: "").uppercased()
        var hexInt: UInt32 = 0
        let scanner: Scanner = Scanner(string: colorString)
        scanner.scanHexInt32(&hexInt)
        let redInt: Double = Double((hexInt&0xFF0000)>>16)
        let greenInt: Double = Double((hexInt&0xFF00)>>8)
        let blueInt: Double = (Double(hexInt&0xFF))
        let color: UIColor = UIColor(red: (CGFloat(redInt / 255.0)), green: (CGFloat(greenInt / 255.0)), blue: (CGFloat(blueInt / 255.0)), alpha: 1.0)
        return color
    }
    
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
    
    
    func createImageWithColor(color:UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

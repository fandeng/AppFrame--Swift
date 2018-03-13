//
//  CommonConfig.swift
//  EducationGrade
//
//  Created by 樊登 on 2017/7/28.
//  Copyright © 2017年 樊登. All rights reserved.
//

import Foundation

let APPDELEGATE = UIApplication.shared.delegate as! AppDelegate

//----------------------------网络请求配置------------------------
let baseRequestUrl = "e" //外网

let baseImgUrl = ""//展示图片


//----------------------------屏幕尺寸定义------------------------
let kScreenW = UIScreen.main.bounds.width      //屏幕宽度

let kScreenH = UIScreen.main.bounds.height     //屏幕高度

//----------------------------字体大小定义------------------------

let SizeScale  = kScreenH > 568 ? 1 : 0.8

let kNavFont      = UIFont.systemFont(ofSize: CGFloat(16 * SizeScale))    //导航栏字体大小

let kTitleFont    = UIFont.systemFont(ofSize: CGFloat(15 * SizeScale)) //标题类字体大小

let kMainFont     = UIFont.systemFont(ofSize: CGFloat(14 * SizeScale))  //正文字体大小

let kSubtitleFont = UIFont.systemFont(ofSize: CGFloat(13 * SizeScale))  //副标题字体大小

let kCaptionFont  = UIFont.systemFont(ofSize: CGFloat(12 * SizeScale))   //时间字体大小

let kSmallFont  = UIFont.systemFont(ofSize: CGFloat(11 * SizeScale))   //时间字体大小

//----------------------------颜色定义------------------------
let kThemeColor = UIColor.colorWithHexString(hex: "#1CB0F6")  //app主色调

let kGrayColor = UIColor.colorWithHexString(hex: "#d9d9d9")  //按钮不可点击颜色

let kBgColor = UIColor.colorWithHexString(hex: "#f0f1f2")  //view背景色

let kNavColor      = UIColor.black    //导航栏字体颜色

let kTitleColor    = UIColor.colorWithHexString(hex: "#333333") //标题类字体颜色

let kMainColor     = UIColor.colorWithHexString(hex: "#666666")  //正文字体颜色

let kSubtitleColor = UIColor.colorWithHexString(hex: "#999999")  //副标题字体颜色

let kCaptionColor  = UIColor.lightGray   //时间字体颜色

		

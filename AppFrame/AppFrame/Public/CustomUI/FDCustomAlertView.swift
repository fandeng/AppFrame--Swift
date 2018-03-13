//
//  FDCustomAlertView.swift
//  AppFrame
//
//  Created by 樊登 on 2018/3/13.
//  Copyright © 2018年 樊登. All rights reserved.
//

import UIKit

typealias customAlertViewClickAction = (Int,FDCustomAlertView) -> ()

//宽
let AlertWidth:CGFloat = 280.0
//栏目间的距离
let CustomSpace:CGFloat = 10.0

class FDCustomAlertView: UIView {
    var customAlertViewClickAction : customAlertViewClickAction!
    //确定按钮背景颜色
    var confirmColor = UIColor()
    //确定按钮文本颜色
    var confirmTitleColor = UIColor()
    //取消按钮背景颜色
    var cancalColor = UIColor()
    //取消按钮文本颜色
    var cancalTitleColor = UIColor()
    //顶部title栏 背景颜色
    var topColor = UIColor()
    // 顶部title栏 文本颜色
    var topTitleColor = UIColor()
    var alertView: UIView?
    var topView: UIView?
    var topLabel: UILabel?
    var titleLabel: UILabel?
    var msgLabel: UILabel?
    var confirmBtn: UIButton?
    var cancleBtn: UIButton?
    var lineView: UIView?
    var verLineView: UIView?
    var isTop: Bool?
    
    /// 重写init方法
    ///
    /// - Parameters:
    ///   - frame: self的frame
    ///   - title: 提示框标题
    ///   - message: 提示框内容
    ///   - confirmTitle: 确定按钮文本
    ///   - cancleTitle: 取消按钮文本
    ///   - isShowTop: 是否显示顶部栏
    ///   - topTitle: 顶部栏按钮
    init(frame : CGRect,title: String, message: String, confirmTitle: String, cancleTitle: String, isShowTop:Bool, topTitle: String) {
        super.init(frame: frame)
        self.isTop = isShowTop
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        self.alertView = UIView()
        self.alertView?.backgroundColor = UIColor.white
        self.alertView?.frame = CGRect(x: 0, y: 0, width: AlertWidth, height: 100)
        self.alertView?.layer.position = self.center
        if isShowTop {
            self.topView = UIView(frame: CGRect(x: 0, y: 0, width: AlertWidth, height: 50))
            self.topLabel = UILabel(frame: CGRect(x: 10, y: 15, width: AlertWidth-20, height: 20))
            self.topLabel?.text = topTitle
            self.topLabel?.textAlignment = .center
            self.topLabel?.font = kTitleFont
            self.topView?.addSubview(self.topLabel!)
            self.alertView?.addSubview(self.topView!)
        }
        var rect = CGRect()
        if self.topView != nil {
            rect = self.topView!.frame
        }
        if title.count > 0 {
            self.titleLabel = self.GetAdaptiveLable(CGRect(x: 2 * CustomSpace, y: 2 * CustomSpace, width: AlertWidth - 4 * CustomSpace, height: 20), AndText: title, andIsTitle: true)
            self.titleLabel?.textAlignment = .center
            let titleW: CGFloat = (self.titleLabel?.bounds.size.width)!
            let titleH: CGFloat = (self.titleLabel?.bounds.size.height)!
            self.titleLabel?.frame = CGRect(x: CGFloat((AlertWidth-titleW) / 2), y: CGFloat(2 * CustomSpace)+rect.maxY, width: CGFloat(titleW), height: CGFloat(titleH))
            self.alertView?.addSubview(self.titleLabel!)
        }
        if self.titleLabel != nil {
            rect = self.titleLabel!.frame
        }
        let y: CGFloat = rect.maxY
        if message.count > 0 {
            self.msgLabel = self.GetAdaptiveLable(CGRect(x:CustomSpace, y:y+CustomSpace, width:AlertWidth-2*CustomSpace, height:20), AndText: message, andIsTitle: false)
            self.msgLabel?.textAlignment = .center
            self.alertView?.addSubview(self.msgLabel!)
            let msgW: CGFloat = (self.msgLabel?.bounds.size.width)!
            let msgH: CGFloat = self.msgLabel!.bounds.size.height
            if isShowTop {
                self.msgLabel?.frame = CGRect(x:(AlertWidth-msgW)/2, y:y+CustomSpace, width:msgW, height:msgH)
            } else {
                self.msgLabel?.frame = (self.titleLabel != nil) ? CGRect(x:(AlertWidth-msgW)/2, y:y+CustomSpace, width:msgW, height:msgH) : CGRect(x:(AlertWidth-msgW)/2, y:2*CustomSpace, width:msgW, height:msgH)
            }
        }
        self.lineView = UIView()
        var msgRect = CGRect()
        if self.msgLabel != nil {
            msgRect = self.msgLabel!.frame
        }
        self.lineView?.frame = (self.msgLabel != nil) ? CGRect(x:0, y:msgRect.maxY+2*CustomSpace, width:AlertWidth, height:1) : CGRect(x:0, y:y+2*CustomSpace, width:AlertWidth, height:1)
        self.lineView?.backgroundColor = UIColor(white: 0.8, alpha: 0.6)
        self.alertView?.addSubview(self.lineView!)
        //两个按钮
        if cancleTitle.count > 0 && confirmTitle.count > 0 {
            self.cancleBtn = UIButton(type: .system)
            let lineRect:CGRect = self.lineView!.frame
            self.cancleBtn?.frame = CGRect(x:0, y:lineRect.maxY, width:(AlertWidth-1)/2, height:40)
            self.cancleBtn?.setBackgroundImage(self.imageWithColor(UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0.2)), for: .normal)
            self.cancleBtn?.setBackgroundImage(self.imageWithColor(UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0.2)), for: .selected)
            self.cancleBtn?.setTitle(cancleTitle, for: .normal)
            self.cancleBtn?.tag = 1
            self.cancleBtn?.addTarget(self, action:#selector(buttonEvent(sender:)) , for: .touchUpInside)
            let maskPath: UIBezierPath = UIBezierPath(roundedRect: (self.cancleBtn?.bounds)!, byRoundingCorners: .bottomLeft, cornerRadii: CGSize.init(width: 5.0, height: 5.0))
            let maskLayer: CAShapeLayer = CAShapeLayer()
            maskLayer.frame = (self.cancleBtn?.bounds)!
            maskLayer.path = maskPath.cgPath
            self.cancleBtn?.layer.mask = maskLayer
            self.alertView?.addSubview(self.cancleBtn!)
        }
        if cancleTitle.count > 0 && confirmTitle.count > 0 {
            self.verLineView = UIView()
            let maxFrame:CGRect = self.cancleBtn!.frame
            let lineRect:CGRect = self.lineView!.frame
            self.verLineView?.frame = CGRect(x:maxFrame.maxX, y:lineRect.maxY, width:1, height:40)
            self.verLineView?.backgroundColor = UIColor(white: 0.8, alpha: 0.6)
            self.alertView?.addSubview(self.verLineView!)
        }
        if cancleTitle.count > 0 && confirmTitle.count > 0 {
            self.confirmBtn = UIButton(type: .system)
            let maxFrame:CGRect = self.verLineView!.frame
            let lineRect:CGRect = self.lineView!.frame
            self.confirmBtn?.frame = CGRect(x:maxFrame.maxX, y:lineRect.maxY, width:(AlertWidth-1)/2+1, height:40)
            self.confirmBtn?.setBackgroundImage(self.imageWithColor(UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0.2)), for: .normal)
            self.confirmBtn?.setBackgroundImage(self.imageWithColor(UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0.2)), for: .selected)
            self.confirmBtn?.setTitle(confirmTitle, for: .normal)
            //[self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.confirmBtn?.tag = 2
            self.confirmBtn?.addTarget(self, action: #selector(buttonEvent(sender:)), for: .touchUpInside)
            let maskPath: UIBezierPath = UIBezierPath(roundedRect: (self.confirmBtn?.bounds)!, byRoundingCorners: .bottomRight, cornerRadii: CGSize.init(width: 5.0, height: 5.0))
            let maskLayer: CAShapeLayer = CAShapeLayer()
            maskLayer.frame = (self.confirmBtn?.bounds)!
            maskLayer.path = maskPath.cgPath
            self.confirmBtn?.layer.mask = maskLayer
            self.alertView?.addSubview(self.confirmBtn!)
        }
        //只有取消按钮
        if cancleTitle.count > 0 && confirmTitle.count == 0 {
            self.cancleBtn = UIButton(type: .system)
            let lineRect:CGRect = self.lineView!.frame
            self.cancleBtn?.frame = CGRect(x:0, y:lineRect.maxY, width:AlertWidth, height:40)
            self.cancleBtn?.setBackgroundImage(self.imageWithColor(UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0.2)), for: .normal)
            self.cancleBtn?.setBackgroundImage(self.imageWithColor(UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0.2)), for: .selected)
            self.cancleBtn?.setTitle(cancleTitle, for: .normal)
            self.cancleBtn?.tag = 1
            self.cancleBtn?.addTarget(self, action:#selector(buttonEvent(sender:)) , for: .touchUpInside)
            let maskPath: UIBezierPath = UIBezierPath(roundedRect: (self.cancleBtn?.bounds)!, byRoundingCorners: [.bottomLeft,.bottomRight], cornerRadii: CGSize.init(width: 5.0, height: 5.0))
            let maskLayer: CAShapeLayer = CAShapeLayer()
            maskLayer.frame = (self.cancleBtn?.bounds)!
            maskLayer.path = maskPath.cgPath
            self.cancleBtn?.layer.mask = maskLayer
            self.alertView?.addSubview(self.cancleBtn!)
        }
        //只有确定按钮
        if confirmTitle.count > 0 && cancleTitle.count == 0 {
            self.confirmBtn = UIButton(type: .system)
            let maxFrame:CGRect = self.verLineView!.frame
            let lineRect:CGRect = self.lineView!.frame
            self.confirmBtn?.frame = CGRect(x:maxFrame.maxX, y:lineRect.maxY, width:AlertWidth, height:40)
            self.confirmBtn?.setBackgroundImage(self.imageWithColor(UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0.2)), for: .normal)
            self.confirmBtn?.setBackgroundImage(self.imageWithColor(UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0.2)), for: .selected)
            self.confirmBtn?.setTitle(confirmTitle, for: .normal)
            self.confirmBtn?.tag = 2
            self.confirmBtn?.addTarget(self, action: #selector(buttonEvent(sender:)), for: .touchUpInside)
            let maskPath: UIBezierPath = UIBezierPath(roundedRect: (self.confirmBtn?.bounds)!, byRoundingCorners: [.bottomRight,.bottomLeft], cornerRadii: CGSize.init(width: 5.0, height: 5.0))
            let maskLayer: CAShapeLayer = CAShapeLayer()
            maskLayer.frame = (self.confirmBtn?.bounds)!
            maskLayer.path = maskPath.cgPath
            self.confirmBtn?.layer.mask = maskLayer
            self.alertView?.addSubview(self.confirmBtn!)
        }
        //计算高度
        let cancleRect:CGRect = self.cancleBtn!.frame
        let confirmRect:CGRect = self.confirmBtn!.frame
        let alertHeight: CGFloat = cancleTitle.count > 0 ? cancleRect.maxY : confirmRect.maxY
        self.alertView?.frame = CGRect(x:0, y:0, width:AlertWidth, height:alertHeight)
        self.alertView?.layer.position = self.center
        self.alertView?.layer.cornerRadius = 5.0
        self.alertView?.clipsToBounds = true
        self.addSubview(self.alertView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func refreshView() {
        if self.isTop! {
            self.topView?.backgroundColor = self.topColor
            self.topLabel?.textColor = self.topTitleColor
            self.lineView?.removeFromSuperview()
            self.verLineView?.removeFromSuperview()
        }
        self.confirmBtn?.backgroundColor = self.confirmColor
        self.confirmBtn?.setTitleColor(self.confirmTitleColor, for: .normal)
        self.cancleBtn?.backgroundColor = self.cancalColor
        self.cancleBtn?.setTitleColor(self.cancalTitleColor, for: .normal)
    }

    // MARK: - 弹出 -
    func showCustomAlertView() {
        let rootWindow: UIWindow = UIApplication.shared.keyWindow!
        rootWindow.addSubview(self)
        self.creatShowAnimation()
    }

    func creatShowAnimation() {
        self.alertView?.layer.position = self.center
        self.alertView?.transform = CGAffineTransform(scaleX: 0.90, y: 0.90)
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveLinear, animations: {    self.alertView?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)

        })
    }

    @objc func buttonEvent(sender:UIButton) {
        if customAlertViewClickAction != nil {
            customAlertViewClickAction(sender.tag, self)
        }
    }

    func GetAdaptiveLable(_ rect: CGRect, AndText contentStr: String, andIsTitle isTitle: Bool) -> UILabel {
        let contentLbl: UILabel = UILabel(frame: rect)
        contentLbl.numberOfLines = 0
        contentLbl.text = contentStr
        contentLbl.textAlignment = .center
        if isTitle {
            contentLbl.font = UIFont.boldSystemFont(ofSize: 16.0)
        } else {
            contentLbl.font = UIFont.systemFont(ofSize: 14.0)

        }
        let mAttrStr: NSMutableAttributedString = NSMutableAttributedString(string: contentStr)
        let mParaStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        mParaStyle.lineBreakMode = .byCharWrapping
        mParaStyle.lineSpacing = 3.0
        mAttrStr.addAttribute(NSAttributedStringKey.paragraphStyle, value: mParaStyle, range: NSMakeRange(0, contentStr.count))
        contentLbl.attributedText = mAttrStr
        contentLbl.sizeToFit()
        return contentLbl
    }

    func imageWithColor(_ color: UIColor) -> UIImage {
        let rect: CGRect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let theImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return theImage
    }

}


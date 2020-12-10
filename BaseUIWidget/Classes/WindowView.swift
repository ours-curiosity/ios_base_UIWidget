//
//  WindowView.swift
//  BaseUIWidget
//
//  Created by walker on 2020/11/10.
//  Copyright (c) 2020 walker. All rights reserved.
// 

import UIKit
import BaseFoundation

public enum WindowLocation {
    case center
    case centerOffset(offset: CGPoint)
    case bottomCenter(offset: CGPoint = .zero)
}

public extension UIView {
    
    /// 在window上展示
    /// - Parameters:
    ///   - location: 位置
    ///   - hasMask: 是否显示蒙版
    func ct_showAtWindow(location: WindowLocation? = .center, hasMask: Bool? = true) {
        var rect = CGRect.init(x: (UIFit.width - self.frame.width) / 2.0, y: (UIFit.height - self.frame.height) / 2.0, width: self.frame.width, height: self.frame.height)
        switch location {
        case .centerOffset(let offset):
            rect = CGRect.init(x: (UIFit.width - self.frame.width) / 2.0 - offset.x, y: (UIFit.height - self.frame.height) / 2.0 - offset.y, width: self.frame.width, height: self.frame.height)
        case .bottomCenter(let offset):
            rect = CGRect.init(x: (UIFit.width - self.frame.width) / 2.0 + offset.x, y: (UIFit.height - self.frame.height) + offset.y, width: self.frame.width, height: self.frame.height)
        default:
            rect = CGRect.init(x: (UIFit.width - self.frame.width) / 2.0, y: (UIFit.height - self.frame.height) / 2.0, width: self.frame.width, height: self.frame.height)
        }
        self.ct_showAtWindow(frame: rect, hasMask: true, maskColor: UIColor.black.withAlphaComponent(0.2), animationDuration: 0.2) { (isFinish) in
        }
    }
    
    
    /// 在window上展示
    /// - Parameters:
    ///   - frame: 视图的frame
    ///   - hasMask: 是否有蒙版
    ///   - maskColor: 蒙版颜色
    ///   - animationDuration: 蒙版动画时长
    func ct_showAtWindow(frame: CGRect, hasMask: Bool, maskColor: UIColor? = UIColor.black.withAlphaComponent(0.2), animationDuration: TimeInterval, animationComplete:((_ isFinish: Bool)->())?) {
        let windowView: UIView? = UIApplication.shared.keyWindow
        if windowView == nil {
            return
        }
        let backView = self.p_createBackView()
        backView.backgroundColor = UIColor.clear
        backView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(windowBackGroundTapAction(tap:))))
        windowView?.addSubview(backView)
        backView.addSubview(self)
        self.frame = frame
        UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 25, initialSpringVelocity: 5, options: AnimationOptions.curveEaseInOut, animations: {
            backView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        }) { (isFinish) in
            animationComplete?(isFinish)
        }
    }
    
    /// 从window上移除当前视图
    /// - Parameter animationComplete: 动画结束的回调
    func ct_removeFormWindow(animationDuration: TimeInterval ,animationComplete: ((_ isFinish: Bool)->())?) {
        if let backView = self.p_getBackView() {
            UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 25, initialSpringVelocity: 5, options: AnimationOptions.curveEaseInOut, animations: {
                backView.backgroundColor = UIColor.clear
                self.alpha = 0
            }) { (isFinish) in
                backView.removeFromSuperview()
                animationComplete?(isFinish)
            }
        }
    }
    
    
    /// 是否正在window上显示
    /// - Returns: 是否在显示
    fileprivate func ct_isShowAtWindow() -> Bool {
        return self.p_getBackView() != nil
    }
    
    @objc func windowBackGroundTapAction(tap: UITapGestureRecognizer) {
        DebugPrint("windowBackGround tap action,tap view: \(String(describing: tap.view))")
    }
    
    /// 生成底部View
    /// - Returns: 底部View
    fileprivate func p_createBackView() -> UIView {
        if let oldView = self.p_getBackView() {
            return oldView
        }
        let backView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIFit.width, height: UIFit.height))
        backView.tag = self.hash
        return backView
    }
    
    
    /// 获得底部的View
    /// - Returns: 底部View
    fileprivate func p_getBackView() -> UIView? {
        
        let windowView: UIView? = UIApplication.shared.keyWindow
        let hashTag = self.hash
        if windowView == nil || windowView?.subviews.count ?? 0 <= 0 {
            return nil
        }
        for view in windowView!.subviews {
            
            if view.tag == hashTag {
                return view
            }
        }
        return nil
    }
}

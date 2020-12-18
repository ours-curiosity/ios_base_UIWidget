//
//  KeyboardMonitor.swift
//  CTBaseUIWidget
//
//  Created by walker on 2020/12/18.
//

import Foundation

/**
 键盘frame改变监控
 */
public enum KeyBoardChangeType {
    case none               // 监测不起作用
    case willShow
    case didShow
    case willHide
    case didHide
    case willChangeFrame
    case didChangeFrame
}

public class KeyBoardMonitor {
    
    public typealias KeyBoardChangeCallBack = ((_ changeType: KeyBoardChangeType, _ startFrame: CGRect, _ endFrame: CGRect, _ duration: TimeInterval, _ userInfo: [AnyHashable: Any]?)->())
    
    private var callBack: KeyBoardChangeCallBack?
    
    // MARK: 单例
    private init(){}
    public static let stand: KeyBoardMonitor = KeyBoardMonitor()
    
    public func monitor(enable: Bool = true, changeCallBack: KeyBoardChangeCallBack?) {
        
        self.callBack = changeCallBack
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: self)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: self)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: self)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: self)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: self)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidChangeFrameNotification, object: self)
        
        if enable == true {
            NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(noti:)), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyBoardDidShow(noti:)), name: UIResponder.keyboardDidShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(noti:)), name: UIResponder.keyboardWillHideNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyBoardDidHide(noti:)), name: UIResponder.keyboardDidHideNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillChangeFrame(noti:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyBoardDidChangeFrame(noti:)), name: UIResponder.keyboardDidChangeFrameNotification, object: nil)
            return
        }
        
        self.callBack?(.none, .zero, .zero, 0, nil)
    }
    
    
    @objc private func keyBoardWillShow(noti: Notification) {
        self.keyBoardChange(type: .willShow, userInfo: noti.userInfo)
    }
    
    @objc private func keyBoardDidShow(noti: Notification) {
        self.keyBoardChange(type: .didShow, userInfo: noti.userInfo)
    }
    
    @objc private func keyBoardWillHide(noti: Notification) {
        self.keyBoardChange(type: .willHide, userInfo: noti.userInfo)
    }
    
    @objc private func keyBoardDidHide(noti: Notification) {
        self.keyBoardChange(type: .didHide, userInfo: noti.userInfo)
    }
    
    @objc private func keyBoardWillChangeFrame(noti: Notification) {
        self.keyBoardChange(type: .willChangeFrame, userInfo: noti.userInfo)
    }
    
    @objc private func keyBoardDidChangeFrame(noti: Notification) {
        self.keyBoardChange(type: .didChangeFrame, userInfo: noti.userInfo)
    }
    
    private func keyBoardChange(type: KeyBoardChangeType, userInfo: [AnyHashable : Any]?) {
        var beginFrame: CGRect? = .zero, endFrame: CGRect? = .zero
        var duration: TimeInterval? = 0
        if userInfo != nil {
            beginFrame = userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect
            endFrame = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
            duration = userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
        }
        self.callBack?(type, beginFrame ?? .zero, endFrame ?? .zero, duration ?? 0, userInfo)
    }
}

//
//  CTMultiLineInputView.swift
//  CTBaseUIWidget
//
//  Created by walker on 2021/1/4.
//

import Foundation
import KMPlaceholderTextView
import CTBaseFoundation

public class CTMultiLineInputView: UIView {
    
    var curTextHeight: CGFloat = 34
    public var maxTextHeight: CGFloat = 82
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialize()
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func initialize() {
        self.backgroundColor = UIColor.white
    }
    
    func setUpUI() {
        self.addSubview(self.textView)
        self.addSubview(self.sendBtn)
        layout()
    }
    
    func layout() {
        self.textView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10.scale)
            make.right.equalToSuperview().offset(-10.scale)
            make.top.equalToSuperview().offset(10.scale)
            make.bottom.equalToSuperview().offset(-10.scale)
        }
    }
    
    // MARK: - public method
    public func showKeyboard(text: String?) {
        self.textView.text = text
        self.alpha = 1.0
        self.ct_showAtWindow(location: .bottomCenter(offset: .zero), hasMask: false, hasGesture: false, animationComplete: nil)
        KeyBoardMonitor.stand.monitor(enable: true) { (_ changeType: KeyBoardChangeType, _ startFrame: CGRect, _ endFrame: CGRect, _ duration: TimeInterval, _ userInfo: [AnyHashable: Any]?) in
            if changeType == .willChangeFrame {
                self.keyboardChanged(endFrame: endFrame, duration: duration)
            }
        }
        self.textView.becomeFirstResponder()
    }
    
    public func hideKeyboard() {
        self.textView.resignFirstResponder()
        self.ct_removeFormWindow(animationDuration: 0.1, animationComplete: nil)
        KeyBoardMonitor.stand.monitor(changeCallBack: nil)
    }
    
    public func clearInputViewContent() {
        self.textView.text = ""
    }
    
    public  func keyboardChanged(endFrame: CGRect, duration: TimeInterval) {
        let oldFrame = self.frame
        let newFrame = CGRect.init(x: 0, y: UIFit.height - endFrame.height - oldFrame.height, width: oldFrame.width, height: oldFrame.height)
        UIView.animate(withDuration: duration) {
            self.frame = newFrame
        }
        DebugPrint("newFrame:\(newFrame)")
    }
    
    // MARK: - private method
    func textViewValueChanged(_ text: String) {
        let textHeight = text.textRect(attributes: self.textView.attributedText.attributes, maxSize: CGSize.init(width: UIFit.width - 20.scale - 15, height: CGFloat.greatestFiniteMagnitude)).size.height
        
        self.fixViewHeight(textHeight: textHeight)
    }
    
    func fixViewHeight(textHeight: CGFloat = 34) {
        
        if textHeight != self.curTextHeight && textHeight >= 34 && textHeight <= self.maxTextHeight {
            let diffHeight = textHeight - self.curTextHeight
            let oldFrame = self.frame
            let newFrame = CGRect.init(x: oldFrame.origin.x, y: oldFrame.origin.y - diffHeight, width: oldFrame.size.width, height: oldFrame.height + diffHeight)
            self.curTextHeight = textHeight <= 34 ? 34 : textHeight
            UIView.animate(withDuration: 0.2, delay: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                self.frame = newFrame
                self.textView.height = self.textView.height + diffHeight
            }, completion: nil)
        }else if textHeight < 34 {
            self.curTextHeight = 34
        }
    }
    
    public lazy var textView: KMPlaceholderTextView = {
        let textView = KMPlaceholderTextView.init()
        textView.placeholder = "Type to chat ..."
        textView.cornerRadius = 4.scale
        textView.font = UIFont.systemFont(ofSize: 17.0)
        textView.delegate = self
        textView.showsVerticalScrollIndicator = false
        textView.showsHorizontalScrollIndicator = false
        if #available(iOS 11.0, *) {
            textView.contentInsetAdjustmentBehavior = .never
        }
        return textView
    }()
    
    public lazy var sendBtn: UIButton = {
        let sendBtn = UIButton.init()
        return sendBtn
    }()
}

extension CTMultiLineInputView: UITextViewDelegate {
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        self.textViewValueChanged(textView.text + text)
        return true
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        self.textViewValueChanged(textView.text)
    }
}

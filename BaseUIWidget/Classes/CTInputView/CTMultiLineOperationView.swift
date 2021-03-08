//
//  CTMultiLineOperationView.swift
//  CTBaseUIWidget
//
//  Created by walker on 2021/3/8.
//

import Foundation
import KMPlaceholderTextView
import CTBaseFoundation

public class CTMultiLineOperationView: UIView {
    var curTextHeight: CGFloat = 34
    /// 最大文本高度
    public var maxTextHeight: CGFloat = 82
    // 最大字数限制
    public var maxTextLen: Int = 150
    // 最小字数限制
    public var minTextLen: Int = 0
    // 是否忽略空格
    public var autoRemoveSpaces: Bool = false
    /// Done按钮事件
    public var doneAction: ((_ text: String?, _ inputView: CTMultiLineOperationView)->())?
    /// cancel按钮事件
    public var cancelAction: ((_ text: String?, _ inputView: CTMultiLineOperationView)->())?
    
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
        self.isUserInteractionEnabled = true
        NotificationCenter.default.addObserver(self, selector: #selector(textViewTextDidChange), name: UITextField.textDidChangeNotification, object: nil)
    }
    
    func setUpUI() {
        self.addSubview(self.textBgView)
        self.textBgView.addSubview(self.textView)
        self.addSubview(self.doneBtn)
        self.addSubview(self.cancelBtn)
        layout()
    }
    
    func layout() {
        
        self.textBgView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16.scale)
            make.right.equalToSuperview().offset(-16.scale)
            make.top.equalToSuperview().offset(12.scale)
            make.bottom.equalToSuperview().offset(-56.scale)
        }
        
        self.textView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5.scale)
            make.right.equalToSuperview().offset(-5.scale)
            make.top.equalToSuperview().offset(3.scale)
            make.bottom.equalToSuperview().offset(-3.scale)
        }
        
        self.cancelBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16.scale)
            make.top.equalTo(self.textBgView.snp.bottom).offset(16.scale)
        }
        
        self.doneBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-16.scale)
            make.top.equalTo(self.textBgView.snp.bottom).offset(16.scale)
        }
    }
    
    @objc private func textViewTextDidChange() {
        // 总的字符
        let fullText = self.textView.text ?? ""
        // 修复后的字符串
        let fixText: String = self.autoRemoveSpaces ? fullText.removeHeadAndTailSpaceAndNewlines() : fullText
        // 截断字符串
        if fixText.countOfChars() > self.maxTextLen {
            self.textView.text = fixText.subString(to: self.maxTextLen)
        }
    }
    
    @objc private func doneBtnAction() {
        self.doneAction?(self.textView.text, self)
    }
    
    @objc private func cancelBtnAction() {
        self.cancelAction?(self.textView.text, self)
    }
    
    // MARK: - public method
    public func showKeyboard(text: String? = "") {
        self.textView.text = text
        self.alpha = 1.0
        self.ct_showAtWindow(location: .bottomCenter(offset: .zero), hasMask: true, hasGesture: true, animationComplete: nil)
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
    }
    
    // MARK: - private method
    func textViewValueChanged(_ text: String) {
        self.textViewTextDidChange()
        let textHeight = text.textRect(attributes: self.textView.attributedText.attributes, maxSize: CGSize.init(width: self.textView.width - 10, height: CGFloat.greatestFiniteMagnitude)).size.height
        
        self.fixViewHeight(textHeight: textHeight)
    }
    
    func fixViewHeight(textHeight: CGFloat = 34) {
        if textHeight != self.curTextHeight && textHeight <= self.maxTextHeight {
            let diffHeight = (textHeight <= 34 ? 34 : textHeight) - self.curTextHeight
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
        textView.ct_cornerRadius = 4.scale
        textView.font = UIFont.systemFont(ofSize: 17.0)
        textView.delegate = self
        textView.showsVerticalScrollIndicator = false
        textView.showsHorizontalScrollIndicator = false
        textView.enablesReturnKeyAutomatically = true
        textView.backgroundColor = UIColor.clear
        return textView
    }()
    
    public lazy var doneBtn: UIButton = {
        let doneBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 60.scale, height: 30.scale))
        doneBtn.setTitle("Done", for: UIControl.State.normal)
        doneBtn.addTarget(self, action: #selector(doneBtnAction), for: .touchUpInside)
        doneBtn.ct_cornerRadius = 6.scale
        return doneBtn
    }()
    
    public lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 60.scale, height: 30.scale))
        cancelBtn.setTitle("Cancel", for: UIControl.State.normal)
        cancelBtn.addTarget(self, action: #selector(cancelBtnAction), for: .touchUpInside)
        return cancelBtn
    }()
    
    public lazy var textBgView: UIView = {
        let textBgView = UIView.init()
        textBgView.backgroundColor = UIColor.white
        return textBgView
    }()
}

extension CTMultiLineOperationView: UITextViewDelegate {
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        self.textViewValueChanged(textView.text + text)
        return true
    }
    public func textViewDidChange(_ textView: UITextView) {
        self.textViewValueChanged(textView.text)
    }
}

extension CTMultiLineOperationView {
    public override func windowBackGroundTapAction(tap: UITapGestureRecognizer) {
        if tap.location(in: self).y < -15 {
            self.hideKeyboard()
        }
    }
}

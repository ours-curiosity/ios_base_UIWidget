//
//  CTInputView.swift
//  CTBaseUIWidget
//
//  Created by walker on 2020/12/29.
//

import UIKit
import CTBaseFoundation
import SnapKit

public class CTInputView: UIView {
//    占位文本
    public var placeHolder: String = "" {
        didSet{
            self.textFiled.placeholder = placeHolder
        }
    }
    // 最大字数限制
    public var maxTextLen: Int = 15
    // 最小字数限制
    public var minTextLen: Int = 0
    // 是否忽略空格
    public var autoRemoveSpaces: Bool = false
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        addNotification()
        setUpUI()
    }

    public convenience init(placeHolder: String?) {
        self.init()
        self.placeHolder = placeHolder ?? ""
        self.textFiled.placeholder = self.placeHolder
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(textFiledDidChange), name: UITextField.textDidChangeNotification, object: nil)
    }
    
    func setUpUI() {
        
        self.addSubview(self.backView)
        self.backView.addSubview(self.cancelBtn)
        self.backView.addSubview(self.doneBtn)
        self.backView.addSubview(self.textFiled)
        
        layout()
    }
    
    func layout() {
        
        self.cancelBtn.snp.remakeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-10.scale - UIFit.tabSafeBottom)
            make.left.equalToSuperview().offset(16.scale)
            make.size.equalTo(CGSize.init(width: 60.scale, height: 30.scale))
        }
        
        self.doneBtn.snp.remakeConstraints { (make) in
            make.right.equalToSuperview().offset(-16.scale)
            make.bottom.equalToSuperview().offset(-10.scale - UIFit.tabSafeBottom)
            make.size.equalTo(CGSize.init(width: 60.scale, height: 30.scale))
        }
        self.textFiled.snp.remakeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(UIFit.width - 32.scale)
            make.height.equalTo(45.scale)
            make.bottom.equalTo(self.cancelBtn.snp.top).offset(-16.scale)
        }
    }
    
    /// 更新输入框的位置
    /// - Parameters:
    ///   - endFrame: 键盘的endframe
    ///   - duration: 键盘的动画duration
    public func keyboardChange(endFrame: CGRect, duration: TimeInterval) {
        let oldFrame = self.backView.frame
        let newFrame = CGRect.init(x: 0, y: 0 - endFrame.height, width: oldFrame.width, height: oldFrame.height)
        UIView.animate(withDuration: duration) {
            self.backView.frame = newFrame
        }
    }
    
    public func showKeyBoard() {
        self.textFiled.becomeFirstResponder()
    }
    
    public func hideKeyBoard() {
        self.textFiled.resignFirstResponder()
    }
    
    @objc private func textFiledDidChange() {
        // 总的字符
        let fullText = self.textFiled.text ?? ""
        // 修复后的字符串
        let fixText: String = self.autoRemoveSpaces ? fullText.removeHeadAndTailSpaceAndNewlines() : fullText
        // 截断字符串
        if fixText.countOfChars() > self.maxTextLen {
            self.textFiled.text = fixText.subString(to: self.maxTextLen)
        }
    }
    
    // MARK: - lazy load --
    public lazy var backView: UIView = {
        let backView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIFit.width, height: UIFit.height))
        backView.backgroundColor = UIColor.clear
        backView.isUserInteractionEnabled = true
        return backView
    }()
    
    public lazy var textFiled: UITextField = {
        let textFiled = UITextField.init()
        textFiled.addPaddingLeft(16.scale)
        textFiled.textColor = UIColor.black
        textFiled.backgroundColor = UIColor.white
        textFiled.placeholder = self.placeHolder
        textFiled.ct_cornerRadius = 8.scale
        textFiled.textAlignment = .center
        textFiled.delegate = self
        return textFiled
    }()
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.itemSize = CGSize.init(width: 76.scale, height: 44.scale)
        flowLayout.minimumInteritemSpacing = 16
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets.init(top: 0, left: 0.scale, bottom: 0, right: 0.scale)
        return flowLayout
    }()
    
    public lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton.init()
        cancelBtn.setTitle("Cancel", for: UIControl.State.normal)
        cancelBtn.setTitleColor(UIColor.white, for: .normal)
        return cancelBtn
    }()
    
    public lazy var doneBtn: UIButton = {
        let done = UIButton.init()
        done.setTitle("Done", for: UIControl.State.normal)
        done.backgroundColor = UIColor.white
        done.setTitleColor(UIColor.black, for: UIControl.State.normal)
        done.ct_cornerRadius = 4.scale
        return done
    }()
}

extension CTInputView: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        // 总的字符
//        let fullText = (textFiled.text ?? "" + string)
//        // 修复后的字符串
//        let fixText: String = self.autoRemoveSpaces ? fullText.removeHeadAndTailSpaceAndNewlines() : fullText
//        // 是否超出最大字数限制
//        if fixText.countOfChars() > self.maxTextLen {
//            return false
//        }else {
//            return true
//        }
        
        self.textFiledDidChange()
        return true
    }
}

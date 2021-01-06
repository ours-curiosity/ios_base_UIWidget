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
    
    public var placeHolder: String = "" {
        didSet{
            self.textFiled.placeholder = placeHolder
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
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


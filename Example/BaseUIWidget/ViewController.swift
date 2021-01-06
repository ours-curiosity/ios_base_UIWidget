//
//  ViewController.swift
//  BaseUIWidget_Example
//
//  Created by walker on 2020/11/11.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import CTBaseUIWidget
import CTBaseFoundation
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        testInviteField()
    }
    
    func testInviteField() {
        
        let filed = InviteFiled.init(frame: CGRect.init(x: 100, y: 400, width: 200, height: 40))
        filed.codeLimit = 4
        filed.inputBackGroundColor = UIColor.lightGray
        filed.cursorColor = UIColor.black
        self.view.addSubview(filed)
    }
    
    @IBAction func smsBtnAction(_ sender: UIButton) {
        
        SysJumpManager.stand.sendSMS(rootVC: self, body: "test")
    }
    
    @IBAction func p_showToast(_ sender: UIButton) {
        
        CTToast.ct_showPositionToast(baseView: nil, message: "这是一个toast", title: nil, image: nil, completion: nil)
    }
    
    @IBAction func p_showIndicator(_ sender: UIButton) {
        
        CTToast.ct_showIndicator(baseView: nil, preventUserAction: true, position: CTToastPosition.center)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            CTToast.ct_hideIndicator(baseView: nil, delay: 0, preventUserAction: false)
        }
    }
    
    @IBAction func inputViewAction(_ sender: UIButton) {
        
        let inptView = CTInputView.init(placeHolder: "test 123")
        
        inptView.frame = UIScreen.main.bounds
        inptView.ct_showAtWindow(location: .bottomCenter(offset: .zero), hasMask: true, hasGesture: nil, animationComplete: nil)
    }
    
    lazy var inputTextView: CTMultiLineInputView = {
        let inputTextView = CTMultiLineInputView.init(frame: CGRect.init(x: 0, y: 0, width: UIFit.width, height: 40 + 24.scale))
        inputTextView.backgroundColor = UIColor.gray
        inputTextView.textBgView.backgroundColor = UIColor.darkGray
        inputTextView.textBgView.ct_cornerRadius = 20
        inputTextView.sendBtnAction = {(text, inputView) in
            DebugPrint("text: \(text)")
        }
        return inputTextView
    }()
    @IBAction func showInputBtnAction(_ sender: UIButton) {
        self.inputTextView.showKeyboard()
    }
}


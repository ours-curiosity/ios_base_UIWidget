//
//  ViewController.swift
//  BaseUIWidget_Example
//
//  Created by walker on 2020/11/11.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import CTBaseUIWidget
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
    
    
    @IBAction func p_showToast(_ sender: UIButton) {
        
        CTToast.ct_showPositionToast(baseView: nil, message: "这是一个toast", title: nil, image: nil, completion: nil)
    }
    
    @IBAction func p_showIndicator(_ sender: UIButton) {
        
        CTToast.ct_showIndicator(baseView: nil, preventUserAction: true, position: CTToastPosition.center)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            CTToast.ct_hideIndicator(baseView: nil, delay: 0, preventUserAction: false)
        }
    }
}

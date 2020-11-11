//
//  ViewController.swift
//  BaseUIWidget_Example
//
//  Created by walker on 2020/11/11.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import BaseUIWidget
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
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

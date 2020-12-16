//
//  SysJumpManager.swift
//  CTBaseUIWidget
//
//  Created by walker on 2020/12/16.
//

import Foundation
import MessageUI
import CTBaseFoundation

public class SysJumpManager: NSObject {
    public static let stand = SysJumpManager()
    private override init(){}
    
    public func sendSMS(rootVC: UIViewController?, body: String?){
        if !MFMessageComposeViewController.canSendText() {
            print("MFMessage can't send text!")
            return
        }
        let smsVC = MFMessageComposeViewController.init()
        smsVC.body = body
        smsVC.messageComposeDelegate = self
        if rootVC != nil{
            rootVC?.present(smsVC, animated: true, completion: nil)
        }else {
            UIViewController.topViewController?.present(smsVC, animated: true, completion: nil)
        }
    }
}

extension SysJumpManager: MFMessageComposeViewControllerDelegate {
    public func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
}

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
    
    public func sendSMS(rootVC: UIViewController?, body: String?, phones: [String]? = nil){
        if !MFMessageComposeViewController.canSendText() {
            print("MFMessage can't send text!")
            return
        }
        let smsVC = MFMessageComposeViewController.init()
        smsVC.body = body
        smsVC.messageComposeDelegate = self
        if phones != nil && phones!.count > 0 {
            smsVC.recipients = phones
        }
        
        if rootVC != nil{
            rootVC?.present(smsVC, animated: true, completion: nil)
        }else {
            UIViewController.topViewController?.present(smsVC, animated: true, completion: nil)
        }
    }
    public func sendEmail(rootVC: UIViewController?,errMsg:String,body:String,title:String,email:String)->Error?{
        /// TODO :
        if MFMailComposeViewController.canSendMail(){//是否可以发邮件 // 如果不能,去系统设置接收邮箱
            let mailView = MFMailComposeViewController()
            mailView.mailComposeDelegate = self
            mailView.setToRecipients([email])//接收邮件的邮箱
            mailView.setSubject(title)
            mailView.setMessageBody(body, isHTML: false)
            if rootVC != nil{
                rootVC?.present(mailView, animated: true, completion: nil)
            }else {
                UIViewController.topViewController?.present(mailView, animated: true, completion: nil)
            }
            return nil
        }else{
            return NSError(domain: "cannot sent", code: -1, userInfo: [:])
        }
    }
}

extension SysJumpManager: MFMessageComposeViewControllerDelegate {
    public func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
}
extension SysJumpManager:MFMailComposeViewControllerDelegate{
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

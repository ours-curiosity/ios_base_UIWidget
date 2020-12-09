//
//  InviteFiled.swift
//  Building6
//
//  Created by walker on 2020/6/24.
//  Copyright © 2020 funlink-tech. All rights reserved.
//

import UIKit
import CoreGraphics

open class InviteFiled: UITextField {
    
    /// 文本被修改的回调
    open var fieldTextDidChanged: ((_ text: String?)->())?
    /// 文本背景颜色
    open var inputBackGroundColor: UIColor = UIColor.darkGray
    
    /// 光标颜色
    open var cursorColor: UIColor = UIColor.blue
    /// 绘制计数
    private var reDrawCount: Int = 0
    /// 计数步数
    private var addStep: Int = 1
    /// 计时器
    private lazy var displayLink: CADisplayLink = {
        let displayLink = CADisplayLink.init(target: self, selector: #selector(p_displayLinkAction))
        if #available(iOS 10.0, *) {
            displayLink.preferredFramesPerSecond = 60
        } else {
            displayLink.frameInterval = 2
        }
        displayLink.add(to: RunLoop.current, forMode: .common)
        return displayLink
    }()
    
    /// 邀请码的位数限制，默认没邀请码
    public var codeLimit: Int = 0 {
        
        didSet {
            if codeLimit > 0 {
                self.tintColor = UIColor.clear
                self.autocorrectionType = .no
                self.displayLink.isPaused = false
            }else {
                codeLimit = 0
                self.tintColor = UIColor.blue
            }
        }
    }
    
    /// 邀请码每个字的区域大小
    open var codeTextSize: CGSize = .zero
    /// 邀请码每个字的区域圆角
    open var codeTextRadius: CGFloat = 4.0
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        p_initialize()
        
        p_setUpUI()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    private func p_initialize() {
        
        p_addNotification()
    }
    
    private func p_setUpUI() {
        
        
    }
    
    private func p_addNotification() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(p_textChanged), name: UITextField.textDidChangeNotification, object: self)
    }
    
    open override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else {
            // 没有邀请码就走原来的绘制逻辑
            super.drawText(in: rect)
            return
        }
        
        if self.codeLimit <= 0 {
            // 没有邀请码就走原来的绘制逻辑
            super.drawText(in: rect)
            return
        }
        
        if self.codeTextSize == .zero {
            // 默认为控件高度
            self.codeTextSize = CGSize.init(width: rect.height, height: rect.height)
        }
        
        // 间距
        var gap: CGFloat = 0.0
        if self.codeLimit > 1 {
            gap = CGFloat.maximum((rect.width - (CGFloat(self.codeLimit) * self.codeTextSize.width)), 0) / CGFloat(self.codeLimit - 1)
        }
        let originY = CGFloat.maximum((rect.height - self.codeTextSize.height) / 2.0, 0)
        let textOriginY = CGFloat.maximum(((rect.height - (self.font ?? UIFont.systemFont(ofSize: 17)).lineHeight) / 2.0), 0)
        /// 坐标系翻转
        context.textMatrix = CGAffineTransform.identity
        context.translateBy(x: 0, y: self.bounds.height)
        context.scaleBy(x: 1, y: -1)
        
        // 光标的位置
        var cursorIndex = -1
        
        for i in 0...(self.codeLimit - 1) {
            
            // 绘制背景
            let codeRect = CGRect.init(x: (gap + self.codeTextSize.width) * CGFloat(i), y: originY, width: self.codeTextSize.width, height: self.codeTextSize.height)
            
            let path = UIBezierPath.init(roundedRect: codeRect, cornerRadius: self.codeTextRadius)
            self.inputBackGroundColor.setFill()
            path.lineWidth = 0
            path.fill()
            
            // 绘制字体
            if self.text != nil && self.text!.count > 0 && i < self.text!.count {
                
                let textPath = UIBezierPath.init(rect: CGRect.init(x: codeRect.origin.x, y:  -textOriginY, width: self.codeTextSize.width, height: self.codeTextSize.height))
                
                let textArr = Array(self.text!)
                let tmpStr: String = String(textArr[Int(i)])
                
                let graph = NSMutableParagraphStyle.init()
                graph.alignment = .center
                
                let attributeString = NSAttributedString.init(string: tmpStr, attributes: [NSAttributedString.Key.font: self.font ?? UIFont.systemFont(ofSize: 17), NSAttributedString.Key.foregroundColor: self.textColor ?? UIColor.black, NSAttributedString.Key.paragraphStyle: graph])
                let framesetter = CTFramesetterCreateWithAttributedString(attributeString)
                let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 1), textPath.cgPath, nil)
                CTFrameDraw(frame, context)
                
                if self.text!.count <= (self.codeLimit - 1) {
                    cursorIndex = self.text!.count
                }
                
            }else if self.text == nil || self.text!.count <= 0 {
                cursorIndex = 0
            }
        }
        
        /// 绘制光标
        if cursorIndex != -1 && self.isFirstResponder {
            let corsorPath = UIBezierPath.init()
            corsorPath.move(to: CGPoint.init(x: (gap + self.codeTextSize.width) * CGFloat(cursorIndex) + (self.codeTextSize.width / 2.0) , y: textOriginY))
            corsorPath.addLine(to: CGPoint.init(x: (gap + self.codeTextSize.width) * CGFloat(cursorIndex) + (self.codeTextSize.width / 2.0) , y: self.codeTextSize.height - textOriginY))
            
            let alpha: CGFloat = (CGFloat(self.reDrawCount) / 20.0)
            
            corsorPath.lineWidth = 2
            corsorPath.lineCapStyle = .round
            self.cursorColor.withAlphaComponent(alpha).setStroke()
            corsorPath.stroke()
        }
    }
    
    
    /// 重写drawText
    /// - Parameter rect: 区域
    open override func drawText(in rect: CGRect) {
        return
    }
    
    /// 定时器
    @objc private func p_displayLinkAction() {
        
        self.reDrawCount += self.addStep
        
        self.setNeedsDisplay()
        
        if self.reDrawCount > 30 {
            self.addStep = -1
        }else if self.reDrawCount < 0 {
            self.addStep = 1
        }
    }
    
    /// text已经改变
    @objc private func p_textChanged() {
        
        if self.text?.count ?? 0 > self.codeLimit && self.codeLimit > 0 {
            let code = self.text?.prefix(self.codeLimit)
            if code != nil {
                self.text = String(code!)
            }
        }
        
        if self.fieldTextDidChanged != nil {
            self.fieldTextDidChanged!(self.text)
        }
    }
    
    
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
    
    open override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
        
        return []
    }
    
}

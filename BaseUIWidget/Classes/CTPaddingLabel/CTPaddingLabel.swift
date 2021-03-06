//
//  CTPaddingLabel.swift
//  BaseUIWidget
//
//  Created by walker on 11/10/2020.
//  Copyright (c) 2020 walker. All rights reserved.
//
//  参考文章：https://www.cnblogs.com/sundaysme/p/11780433.html

import UIKit

/// 带内边距的UILabel
public class CTPaddingLabel: UILabel {

    private var padding: UIEdgeInsets = .zero
    
    @IBInspectable
    public var paddingLeft: CGFloat {
        get { return padding.left }
        set { padding.left = newValue }
    }
    
    @IBInspectable
    public var paddingRight: CGFloat {
        get { return padding.right }
        set { padding.right = newValue }
    }
    
    @IBInspectable
    public var paddingTop: CGFloat {
        get { return padding.top }
        set { padding.top = newValue }
    }
    
    @IBInspectable
    public var paddingBottom: CGFloat {
        get { return padding.bottom }
        set { padding.bottom = newValue }
    }
    
    public override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: self.padding))
    }

    public override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insets = self.padding
        var rect = super.textRect(forBounds: bounds.inset(by: insets), limitedToNumberOfLines: numberOfLines)
        rect.origin.x    -= insets.left
        rect.origin.y    -= insets.top
        rect.size.width  += (insets.left + insets.right)
        rect.size.height += (insets.top + insets.bottom)
        return rect
    }
}

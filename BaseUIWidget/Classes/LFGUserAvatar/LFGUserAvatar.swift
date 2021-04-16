//
//  LFGUserAvatar.swift
//  LFGMe
//
//  Created by 2020 on 2021/4/14.
//

import UIKit
import Kingfisher
@objcMembers

public class LFGUserAvatar:UIView{

    public var avatarFrameView:UIImageView?
    public var avatarView:UIImageView?
    var placeHolder : UIImage?
    public var avatarViewbgColor:UIColor = .clear
    public var avatarFrameViewWidth:CGFloat?{
        didSet{
            if let w = avatarFrameViewWidth{
                avatarView?.ct_cornerRadius = w/2
            }
        }
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public init(placeholder img:UIImage? = nil) {
        super.init(frame: .zero)
        setup()
        placeHolder = img
        updateImage(avatar: img)
    }
    public init(url avatar:String? = nil,avatarFrame:String? = nil) {
        super.init(frame: .zero)
        setup()
        updateURL(avatar: avatar, avatarFrame: avatarFrame)
    }
    public init(img avatar:UIImage? = nil,avatarFrame:UIImage? = nil) {
        super.init(frame: .zero)
        setup()
        updateImage(avatar: avatar, avatarFrame: avatarFrame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public override func layoutSubviews() {
        if let _avatarView = avatarView{
            _avatarView.ct_cornerRadius = _avatarView.width/2
            _avatarView.backgroundColor = avatarViewbgColor
        }
    }
    
    private func setup(){
        avatarFrameView = UIImageView()
        avatarView  = UIImageView()
        avatarView?.contentMode = .scaleAspectFill
        avatarFrameView?.contentMode = .scaleAspectFill
        avatarFrameView?.backgroundColor = .clear
        avatarView?.backgroundColor = .clear
        addSubview(avatarView!)
        addSubview(avatarFrameView!)
        
        avatarFrameView?.snp.makeConstraints({ (maker) in
            maker.edges.equalToSuperview()
        })
        avatarView?.snp.makeConstraints({ (maker) in
            maker.width.equalToSuperview().multipliedBy(0.8)
            maker.height.equalToSuperview().multipliedBy(0.8)
            maker.center.equalToSuperview()
        })
        
    }
    /// 更新头像 - url
    public func updateURL(avatar:String? = nil,avatarFrame:String? = nil) {
        if let _avatar = avatar{
            avatarView?.kf.setImage(with: URL(string: _avatar))
        }
        if let _avatarFrame = avatarFrame{
            avatarFrameView?.kf.setImage(with: URL(string: _avatarFrame))
        }
        if avatar == nil,avatarFrame == nil{
            avatarView?.image = placeHolder
        }
        layoutSubviews()
    }
    /// 更新头像 - UIImage
    public func updateImage(avatar:UIImage? = nil,avatarFrame:UIImage? = nil) {
        if let _avatar = avatar{
            avatarView?.image = _avatar
        }
        if let _avatarFrame = avatarFrame{
            avatarFrameView?.image = _avatarFrame
        }
        if avatar == nil,avatarFrame == nil{
            avatarView?.image = placeHolder
        }
        layoutSubviews()
    }
}

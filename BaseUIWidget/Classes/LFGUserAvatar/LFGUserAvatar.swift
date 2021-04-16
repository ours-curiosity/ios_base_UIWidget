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
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    public init(url avatar:String,avatarFrame:String) {
        super.init(frame: .zero)
        setup()
        updateURL(avatar: avatar, avatarFrame: avatarFrame)
    }
    public init(img avatar:UIImage,avatarFrame:UIImage) {
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
            _avatarView.layer.masksToBounds = true
        }
    }
    
    private func setup(){
        avatarFrameView = UIImageView()
        avatarView  = UIImageView()
        avatarView?.contentMode = .scaleAspectFill
        avatarFrameView?.contentMode = .scaleAspectFill

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
    public func updateURL(avatar:String,avatarFrame:String) {
        avatarView?.kf.setImage(with: URL(string: avatar))
        avatarFrameView?.kf.setImage(with: URL(string: avatarFrame))
        layoutSubviews()
    }
    /// 更新头像 - UIImage
    public func updateImage(avatar:UIImage,avatarFrame:UIImage) {
        avatarView?.image = avatar
        avatarFrameView?.image = avatarFrame
        layoutSubviews()
    }
}

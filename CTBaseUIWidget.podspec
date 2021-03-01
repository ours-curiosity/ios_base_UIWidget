#
# Be sure to run `pod lib lint BaseUIWidget.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'CTBaseUIWidget'
    s.version          = '0.4.8.1'
    s.summary          = 'iOS 快速开发时可用的UI组件.'
    
    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!
    
    s.description      = <<-DESC
    iOS 快速开发时可用的UI组件.
    DESC
    
    s.homepage         = 'https://github.com/ours-curiosity/ios_base_UIWidget'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'ours-curiosity' => 'ours.curiosity@gmail.com' }
    s.source           = { :git => 'https://github.com/ours-curiosity/ios_base_UIWidget.git', :tag => s.version.to_s }
    s.social_media_url = 'https://ours-curiosity.github.io/'
    s.requires_arc     = true
    
    s.ios.deployment_target = '10.0'
    s.swift_version = "5.0"
    
    s.source_files = 'BaseUIWidget/Classes/**/*'
    
    # WindowView
    s.subspec 'WindowView' do |sp|
        sp.source_files = 'BaseUIWidget/Classes/CTInputView/WindowView.swift'
    end
    
    # CTPaddingLabel
    s.subspec 'CTPaddingLabel' do |sp|
        sp.source_files = 'BaseUIWidget/Classes/CTPaddingLabel/*'
    end
    
    # SysJumpManager
    s.subspec 'SysJumpManager' do |sp|
        sp.source_files = 'BaseUIWidget/Classes/JumpManager/*'
    end
    
    # keyboard monitor
    s.subspec 'KeyBoardMonitor' do |sp|
        sp.source_files = 'BaseUIWidget/Classes/CTInputView/KeyboardMonitor.swift'
    end
    
    # CTToast
    s.subspec 'CTToast' do |sp|
        sp.source_files = 'BaseUIWidget/Classes/CTToast/*'
        sp.dependency 'Toast-Swift'
    end
    
    # InviteTextFiled
    s.subspec 'InviteFiled' do |sp|
        sp.source_files = 'BaseUIWidget/Classes/InviteFiled/*'
    end
    
    # ActiveLabel
    s.subspec 'ActiveLabel' do |sp|
        sp.source_files = 'BaseUIWidget/Classes/ActiveLabel/*'
    end
    
    # InputView
    s.subspec 'CTInputView' do |sp|
        sp.source_files = 'BaseUIWidget/Classes/CTInputView/*'
        sp.dependency 'SnapKit'
        sp.dependency 'KMPlaceholderTextView'
        sp.dependency 'CTBaseFoundation/Extension'
        s.dependency 'CTBaseFoundation/UIKit'
    end
    
    s.dependency 'CTBaseFoundation/UIKit'
end

#
# Be sure to run `pod lib lint BaseUIWidget.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'BaseUIWidget'
    s.version          = '0.1.0'
    s.summary          = 'iOS 快速开发时可用的UI组件.'
    
    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!
    
    s.description      = <<-DESC
    iOS 快速开发时可用的UI组件.
    DESC
    
    s.homepage         = 'https://github.com/ghostlordstar/BaseUIWidget'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'walker' => 'heshanzhang@outlook.com' }
    s.source           = { :git => 'https://github.com/ghostlordstar/BaseUIWidget.git', :tag => s.version.to_s }
    s.social_media_url = 'https://ours-curiosity.github.io/'
    s.requires_arc     = true

    s.ios.deployment_target = '10.0'
    s.swift_version = "5.0"
    
    s.source_files = 'BaseUIWidget/Classes/**/*'
    
    # s.resource_bundles = {
    #   'BaseUIWidget' => ['BaseUIWidget/Assets/*.png']
    # }
    
    # s.public_header_files = 'Pod/Classes/**/*.h'
    # s.frameworks = 'UIKit', 'MapKit'
    s.dependency 'Toast-Swift'
    s.dependency 'BaseFoundation/Core', :git => 'https://github.com:ours-curiosity/ios_base_foundation.git'

end

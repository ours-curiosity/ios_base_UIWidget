# BaseUIWidget

[![CI Status](https://img.shields.io/travis/ghostlordstar/BaseUIWidget.svg?style=flat)](https://travis-ci.org/ghostlordstar/BaseUIWidget)
[![Version](https://img.shields.io/cocoapods/v/BaseUIWidget.svg?style=flat)](https://cocoapods.org/pods/BaseUIWidget)
[![License](https://img.shields.io/cocoapods/l/BaseUIWidget.svg?style=flat)](https://cocoapods.org/pods/BaseUIWidget)
[![Platform](https://img.shields.io/cocoapods/p/BaseUIWidget.svg?style=flat)](https://cocoapods.org/pods/BaseUIWidget)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## ios UI各种封装组件库
  `BaseUIWidget`

## 要求：
- swift:5.0
- iOS：10.0

## 使用：

> 1. 首先添加私有库`repo`到`pod`
```
pod repo add CTSpecs https://github.com/ours-curiosity/CTSpecs.git
```
> 2. 在`Podfile` 中添加私有库的源`source`
```
source 'https://github.com/ours-curiosity/CTSpecs'
```
> 3. 添加以下语句到`Podfile`文件
```
pod 'BaseUIWidget' 
```

###  只导入toast(CTToast)：
```
pod 'BaseUIWidget/CTToast'
```

###  只导入邀请码输入框(InviteFiled)：
```
pod 'BaseFoundation/InviteFiled' 
```

## 备注：
* 1.无论导入全部还是部分功能，都会导入`Core`相关部分。
* 2.发现库版本号与github上最新版本不一致时请`pod update`。
* 3.发现问题请提交issue。


## License

BaseUIWidget is available under the MIT license. See the LICENSE file for more info.

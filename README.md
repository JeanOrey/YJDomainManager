# YJDomainManager

[![CI Status](https://img.shields.io/travis/YJ/YJDomainManager.svg?style=flat)](https://travis-ci.org/YJ/YJDomainManager)
[![Version](https://img.shields.io/cocoapods/v/YJDomainManager.svg?style=flat)](https://cocoapods.org/pods/YJDomainManager)
[![License](https://img.shields.io/cocoapods/l/YJDomainManager.svg?style=flat)](https://cocoapods.org/pods/YJDomainManager)
[![Platform](https://img.shields.io/cocoapods/p/YJDomainManager.svg?style=flat)](https://cocoapods.org/pods/YJDomainManager)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

YJDomainManager is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'YJDomainManager'
```

## Author

YJ, jeanorey_302941048@163.com

## License

YJDomainManager is available under the MIT license. See the LICENSE file for more info.

# 示例
## 初始化 
    YJDomainManager *manager = [YJDomainManager manager];

## 显示自定义地址，默认为NO
    manager.showManualInput = YES;

## 配置服务器地址
    manager.configureDomainBlock = ^NSArray<YJDomainModel *> * _Nonnull{
        YJDomainModel *local = [YJDomainModel itemWithType:YJDomainTypeLocal domainName:@"本地" baseUrl:@"https:www.baidu.com"];
        YJDomainModel *test = [YJDomainModel itemWithType:YJDomainTypeTest domainName:@"测试" baseUrl:@"https:www.cocoachina.com"];
        YJDomainModel *produce = [YJDomainModel itemWithType:YJDomainTypeProduce domainName:@"发布" baseUrl:@"https:www.code4app.com"];
        return @[local,test,produce];
    };
## 弹出事件
    [manager chooseDomianCompletion:^(NSString * _Nonnull baseUrl, NSString * _Nonnull domainName) {
        NSLog(@"baseUrl = %@\ndomainName = %@",baseUrl,domainName);
    }];

//
//  YJViewController.m
//  YJDomainManager
//
//  Created by YJ on 04/10/2021.
//  Copyright (c) 2021 YJ. All rights reserved.
//

#import "YJViewController.h"
#import <YJDomainManager/YJDomainManager.h>

@interface YJViewController ()

@property (nonatomic,strong) UIButton *urlButton;

@end

@implementation YJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    YJDomainManager *manager = [YJDomainManager manager];
    //显示自定义地址
    manager.showManualInput = YES;
    //配置服务器地址
    manager.configureDomainBlock = ^NSArray<YJDomainModel *> * _Nonnull{
       
       YJDomainModel *local = [YJDomainModel itemWithType:YJDomainTypeLocal domainName:@"本地" baseUrl:@"https:www.baidu.com"];
       
        YJDomainModel *test = [YJDomainModel itemWithType:YJDomainTypeTest domainName:@"测试" baseUrl:@"https:www.cocoachina.com"];
        
        YJDomainModel *produce = [YJDomainModel itemWithType:YJDomainTypeProduce domainName:@"发布" baseUrl:@"https:www.code4app.com"];
        
        return @[local,test,produce];
        
    };
    
    _urlButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _urlButton.frame = CGRectMake(0, 0, self.view.bounds.size.width, 44);
    _urlButton.center = self.view.center;
    [_urlButton setTitle:[NSString stringWithFormat:@"%@ - %@",[YJDomainManager manager].domainName,[YJDomainManager manager].baseUrl] forState:UIControlStateNormal];
    [_urlButton.titleLabel setFont:[UIFont systemFontOfSize:14 weight:UIFontWeightMedium]];
    [_urlButton addTarget:self action:@selector(changeBaseUrlAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_urlButton];    
}

- (void)changeBaseUrlAction:(UIButton *)sender {
    //弹出URL
    [[YJDomainManager manager] chooseDomianCompletion:^(NSString * _Nonnull baseUrl, NSString * _Nonnull domainName) {

        NSLog(@"baseUrl = %@\ndomainName = %@",baseUrl,domainName);
        [sender setTitle:[NSString stringWithFormat:@"%@ - %@",domainName,baseUrl] forState:UIControlStateNormal];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

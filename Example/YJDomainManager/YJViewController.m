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
@property (nonatomic,strong) UIButton *environmentButton;
@end

@implementation YJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    YJDomainModel *local1 = [YJDomainModel itemWithType:YJDomainTypeLocal domainName:@"本地环境1" baseUrl:@"https:www.localtest1.com"];
    YJDomainModel *local2 = [YJDomainModel itemWithType:YJDomainTypeLocal domainName:@"本地环境2" baseUrl:@"https:www.localtest2.com"];
    
    YJDomainModel *test1 = [YJDomainModel itemWithType:YJDomainTypeTest domainName:@"测试环境1" baseUrl:@"https:www.betatest1.com"];
    YJDomainModel *test2 = [YJDomainModel itemWithType:YJDomainTypeTest domainName:@"测试环境2" baseUrl:@"https:www.betatest2.com"];
     
    YJDomainModel *produce1 = [YJDomainModel itemWithType:YJDomainTypeProduce domainName:@"发布环境1" baseUrl:@"https:www.production1.com"];
    YJDomainModel *produce2 = [YJDomainModel itemWithType:YJDomainTypeProduce domainName:@"发布环境2" baseUrl:@"https:www.production2.com"];
    
    
    YJDomainManager *manager = [YJDomainManager manager];
    //显示自定义地址
    manager.showManualInput = YES;
    //实时刷新url
    manager.allowRefresh = YES;
    //配置服务器地址
    __weak typeof(self) weakSelf = self;
    manager.configureDomainBlock = ^NSArray<YJDomainModel *> * _Nonnull{
        if (weakSelf.environmentButton.selected) {
            return @[local2,test2,produce2];
        }else {
            return @[local1,test1,produce1];
        }
    };
    
    _urlButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _urlButton.frame = CGRectMake(0, 0, self.view.bounds.size.width, 44);
    _urlButton.center = self.view.center;
    [_urlButton setTitle:[NSString stringWithFormat:@"%@ - %@",[YJDomainManager manager].domainName,[YJDomainManager manager].baseUrl] forState:UIControlStateNormal];
    [_urlButton.titleLabel setFont:[UIFont systemFontOfSize:14 weight:UIFontWeightMedium]];
    [_urlButton addTarget:self action:@selector(changeBaseUrlAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_urlButton];
    
    _environmentButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _environmentButton.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-100)/2, CGRectGetMaxY(_urlButton.frame)+20, 100, 44);
    [_environmentButton setTitle:@"环境1" forState:UIControlStateNormal];
    [_environmentButton setTitle:@"环境2" forState:UIControlStateSelected];
    [_environmentButton addTarget:self action:@selector(switchEnvironmentAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_environmentButton];
}

- (void)changeBaseUrlAction:(UIButton *)sender {
    //弹出URL
    [[YJDomainManager manager] chooseDomianCompletion:^(NSString * _Nonnull baseUrl, NSString * _Nonnull domainName) {

        NSLog(@"baseUrl = %@\ndomainName = %@",baseUrl,domainName);
        [sender setTitle:[NSString stringWithFormat:@"%@ - %@",domainName,baseUrl] forState:UIControlStateNormal];
    }];
}

- (void)switchEnvironmentAction:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  YJDomainManager.m
//  TeacherProject
//
//  Created by apple mini on 2021/4/10.
//

#define YJSaveDomainType    @"YJSaveDomainType"
#define YJManualInputKey   @"YJManualInputKey"

#import "YJDomainManager.h"
#import <BRPickerView/BRPickerView.h>

@interface YJDomainManager()

@property (nonatomic,assign,readwrite) YJDomainType domainType;

@property (nonatomic,strong,readwrite) NSString *domainName;

@property (nonatomic,strong,readwrite) NSString *baseUrl;

@end

static YJDomainManager  *domainManager = nil;
@implementation YJDomainManager

+ (instancetype)manager{
    static dispatch_once_t token = 0;
    dispatch_once(&token, ^{
        domainManager = [[self.class alloc]init];
        #ifdef DEBUG
        domainManager.domainType = [NSUserDefaults.standardUserDefaults integerForKey:YJSaveDomainType];
        #else
        domainManager.domainType = YJDomainTypeProduce;
        #endif
    });
    return domainManager;
}

- (NSString *)domainName {
    if (self.domainType==YJDomainTypeManualInput) {
        _domainName = @"自定义";
    }else {
        if (self.configureDomainBlock) {
            [self.configureDomainBlock() enumerateObjectsUsingBlock:^(YJDomainModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    #ifdef DEBUG
                if (obj.domainType==self.domainType) {
                    _domainName = obj.title;
                    *stop = YES;
                }
    #else
                if (obj.domainType==YJDomainTypeProduce) {
                    _domainName = obj.title;
                    *stop = YES;
                }
    #endif
            }];
        }else {
            _domainName = @"未设置域名";
        }
    }
    return _domainName;
}

- (NSString *)baseUrl {
    if (self.domainType==YJDomainTypeManualInput) {
        _baseUrl = [NSUserDefaults.standardUserDefaults objectForKey:YJManualInputKey];
    }else {
        if (self.configureDomainBlock) {
            [self.configureDomainBlock() enumerateObjectsUsingBlock:^(YJDomainModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    #ifdef DEBUG
                if (obj.domainType==self.domainType) {
                    _baseUrl = obj.baseUrl;
                    *stop = YES;
                }
    #else
                if (obj.domainType==YJDomainTypeProduce) {
                    _baseUrl = obj.baseUrl;
                    *stop = YES;
                }
    #endif
            }];
        }else {
            _baseUrl = @"未设置域名";
        }
    }
    return _baseUrl;
}

- (void)chooseDomianCompletion:(void (^__nullable)(NSString *baseUrl,NSString *domainName))completion {
    if (self.configureDomainBlock) {
        NSMutableArray <NSString *> *nameMut = [NSMutableArray array];
        NSMutableArray <YJDomainModel *> * lists = [NSMutableArray arrayWithArray:self.configureDomainBlock()];
        if (self.showManualInput) {
            YJDomainModel *input = [YJDomainModel itemWithType:YJDomainTypeManualInput domainName:@"自定义" baseUrl:@""];
            [lists addObject:input];
        }
        [lists enumerateObjectsUsingBlock:^(YJDomainModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [nameMut addObject:obj.title];
        }];
        [BRStringPickerView showPickerWithTitle:@"切换地址" dataSourceArr:nameMut selectIndex:domainManager.domainType resultBlock:^(BRResultModel * _Nullable resultModel) {
            YJDomainType type = lists[resultModel.index].domainType;
            domainManager.domainType = type;
            if (type==YJDomainTypeManualInput) {
                UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"手动输入" message:nil preferredStyle:UIAlertControllerStyleAlert];
                [alertCtrl addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                    textField.textAlignment = NSTextAlignmentLeft;
                    textField.keyboardType = UIKeyboardTypeURL;
                    textField.placeholder = @"请输入域名";
                    NSString *localInput = [[NSUserDefaults standardUserDefaults] objectForKey:YJManualInputKey];
                    textField.text = localInput;
                }];
                [alertCtrl addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
                [alertCtrl addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    UITextField *domainTextField = alertCtrl.textFields.firstObject;
                    if (domainTextField.text.length>0) {
                        [NSUserDefaults.standardUserDefaults setInteger:type forKey:YJSaveDomainType];
                        [NSUserDefaults.standardUserDefaults setObject:domainTextField.text forKey:YJManualInputKey];
                        if (completion) {
                            completion(self.baseUrl,self.domainName);
                        }
                    }
                }]];
                [UIApplication.sharedApplication.delegate.window.rootViewController presentViewController:alertCtrl animated:true completion:nil];
            }else {
                [NSUserDefaults.standardUserDefaults setInteger:type forKey:YJSaveDomainType];
                [NSUserDefaults.standardUserDefaults synchronize];
                if (completion) {
                    completion(self.baseUrl,self.domainName);
                }
            }
        }];
    }else {
        UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:nil message:@"请设置域名" preferredStyle:UIAlertControllerStyleAlert];
        [alertCtrl addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        [UIApplication.sharedApplication.delegate.window.rootViewController presentViewController:alertCtrl animated:true completion:nil];
    }
}

@end

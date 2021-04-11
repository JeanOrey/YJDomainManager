//
//  YJDomainManager.h
//  TeacherProject
//
//  Created by apple mini on 2021/4/10.
//

#import <Foundation/Foundation.h>
#import "YJDomainModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YJDomainManager : NSObject

@property (nonatomic,copy) NSArray <YJDomainModel *> *(^configureDomainBlock)(void);

@property (nonatomic,assign,readonly) YJDomainType domainType;

@property (nonatomic,strong,readonly) NSString *domainName;

@property (nonatomic,strong,readonly) NSString *baseUrl;

@property (nonatomic,assign) BOOL showManualInput;//展示手动输入

+ (instancetype)manager;

- (void)chooseDomianCompletion:(void (^__nullable)(NSString *baseUrl,NSString *domainName))completion;

@end

NS_ASSUME_NONNULL_END

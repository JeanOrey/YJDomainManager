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

/**
 * @discussion  allowRefresh 是否开启实时刷新baseUrl等信息，默认为NO
 *  适用于同一个类型下需访问不同服务器的情况。 比如“发布”环境下需要访问不同的中英文服务器，可开启 allowRefresh 实时刷新baseUrl信息
 *  若无此需求，建议不要开启 allowRefresh
 */
@property (nonatomic,assign) BOOL allowRefresh;

+ (instancetype)manager;

- (void)chooseDomianCompletion:(void (^__nullable)(NSString *baseUrl,NSString *domainName))completion;

@end

NS_ASSUME_NONNULL_END

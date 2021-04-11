//
//  YJDomainModel.h
//  TeacherProject
//
//  Created by apple mini on 2021/4/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,YJDomainType) {
    YJDomainTypeLocal = 0, //本地
    YJDomainTypeTest, //测试
    YJDomainTypeProduce,//发布
    YJDomainTypeManualInput//手动输入
};

@interface YJDomainModel : NSObject
//域名或IP类型
@property (nonatomic,assign) YJDomainType domainType;
//域名代称, 如： 本地环境、开发环境、发布环境..
@property (nonatomic,strong) NSString *title;
//url
@property (nonatomic,strong) NSString *baseUrl;

+ (instancetype)itemWithType:(YJDomainType)domainType domainName:(NSString *)title baseUrl:(NSString *)url;

@end

NS_ASSUME_NONNULL_END

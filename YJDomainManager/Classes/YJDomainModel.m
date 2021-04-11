//
//  YJDomainModel.m
//  TeacherProject
//
//  Created by apple mini on 2021/4/10.
//

#import "YJDomainModel.h"

@implementation YJDomainModel

+ (instancetype)itemWithType:(YJDomainType)domainType domainName:(NSString *)title baseUrl:(NSString *)url {
    YJDomainModel *model = [[YJDomainModel alloc]init];
    model.domainType = domainType;
    model.title = title;
    model.baseUrl = url;
    return model;
}

@end

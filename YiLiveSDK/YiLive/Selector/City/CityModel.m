//
//  CityModel.m
//  Login
//
//  Created by zhenglj on 2018/9/06.
//  Copyright © 2018年 zlj. All rights reserved.
//

#import "CityModel.h"


@implementation FYLProvince

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"name" : @"v",
             @"city" : @"n"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"city" : [City class]};
}

@end

@implementation City

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"name" : @"v",
             @"town" : @"n"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"town" : [FYLTown class]};
}

@end

@implementation FYLTown

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"name" : @"v"};
}

@end

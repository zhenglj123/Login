//
//  CityModel.h
//  Login
//
//  Created by zhenglj on 2018/9/06.
//  Copyright © 2018年 zlj. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FYLProvince,City,FYLTown;

@interface FYLProvince : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *city;

@end

@interface City : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *town;

@end


@interface FYLTown : NSObject

@property (nonatomic, copy) NSString *name;

@end

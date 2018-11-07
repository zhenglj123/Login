//
//  UIImageExtension.m
//  YiLive
//
//  Created by Zhenglj on 2018/10/22.
//  Copyright © 2018年 郑吕杰. All rights reserved.
//

#import "UIImageExtension.h"


@implementation UIImage (Extension)


+(instancetype)imageWithOriginalImageName:(NSString *)imageName{
  
  return [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
  
}


@end

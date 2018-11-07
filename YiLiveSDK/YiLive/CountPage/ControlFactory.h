//
//  ControlFactory.h
//  YiLive
//
//  Created by Zhenglj on 2018/10/22.
//  Copyright © 2018年 郑吕杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ControlFactory : NSObject

+ (UIBarButtonItem*)createBackBarButtonItemWithTarget:(id)target action:(SEL)action;

+ (UIBarButtonItem*)createCloseBarButtonItemWithTarget:(id)target action:(SEL)action;

+ (UIBarButtonItem*)createBarButtonItemWithTitle:(NSString*)title addTarget:(id)target action:(SEL)action;


//+ (UIBarButtonItem*)createBarButtonItemWithTitle2:(NSString*)title addTarget:(id)target action:(SEL)action;

+ (UITabBarItem*) createTabbarItem:(NSString*)title withImage:(NSString*)unimg withHeightLightImage:(NSString*)highImg;

//+ (UILabel*) createThemeLabel;
@end

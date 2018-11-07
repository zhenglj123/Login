//
//  AppDelegate.m
//  YiLive
//
//  Created by Zhenglj on 2018/10/10.
//  Copyright © 2018年 郑吕杰. All rights reserved.
//

#import "AppDelegate.h"
#import "Login.h"




@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
  NSLog(@"PrefixHeader创建运行成功");
  //导航栏颜色
  [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
  //控制器初始化
  Login *login=[[Login alloc]init];
  //login赋值给nav
  UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
  //跳转控制器
  self.window.rootViewController = nav;
  //属性色彩
  NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1], NSForegroundColorAttributeName,nil];
  //设置标题文本属性
  [nav.navigationBar setTitleTextAttributes:attributes];
  
  //微信支付
  float version = [[[UIDevice currentDevice] systemVersion] floatValue];
  if(version >= IOS8){//ios8+ IconBadge需要授权
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
  }
 
  
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
  NSLog(@"应用将退出前台活动");
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
  NSLog(@"应用进入后台");
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
  NSLog(@"应用将进入前台");
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
  NSLog(@"应用进入前台活动");
}


- (void)applicationWillTerminate:(UIApplication *)application {
  NSLog(@"清楚内存，退出应用");
}


//界面交互掩码
-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
   NSLog(@"适配横竖屏");
  if(_allowRotation == 1){
    return UIInterfaceOrientationMaskLandscape;
  }else{
    return UIInterfaceOrientationMaskPortrait;
  }
}



@end

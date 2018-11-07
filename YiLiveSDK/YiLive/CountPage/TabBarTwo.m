//
//  TabBarTwo.m
//  YiLive
//
//  Created by Zhenglj on 2018/10/23.
//  Copyright © 2018年 郑吕杰. All rights reserved.
//

#import "TabBarTwo.h"
#import "BaseNavigationVC.h"
#import "UIImageExtension.h"


@interface TabBarTwo ()

@end

@implementation TabBarTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubViewsControllers];
    [self customTabbarItem];
}

-(void)addSubViewsControllers{
  
  NSArray *classControllers = @[@"HomePage",@"FindPage",@"ChatPage",@"MePage"];
  NSMutableArray *conArr = [NSMutableArray array];
  
  for (int i = 0; i < classControllers.count; i ++) {
    Class cts = NSClassFromString(classControllers[i]);
    UIViewController *vc = [[cts alloc] init];
    UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:vc];
    [conArr addObject:naVC];
  }
  self.viewControllers = conArr;
}

-(void)customTabbarItem{
  
  NSArray *titles = @[@"首页",@"发现",@"消息",@"我的"];
  NSArray *normalImages = @[@"image_home.png", @"image_find.png", @"image_chat.png", @"image_my.png"];
  NSArray *selectImages = @[@"image_home_select", @"image_find_select", @"image_voucher_select", @"image_my_select"];
  
  for (int i = 0; i < titles.count; i++) {
    UIViewController *vc = self.viewControllers[i];
    UIImage *normalImage = [UIImage imageWithOriginalImageName:normalImages[i]];
    UIImage *selectImage = [UIImage imageWithOriginalImageName:selectImages[i]];
    vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:titles[i] image:normalImage selectedImage:selectImage];
  }
  //设置TabBar的颜色
  //    [self.tabBar setBarTintColor:kNavigationBarBg];
  
}

/************************************
 //想让TabBarItem跳动可以打开下面的代码
 ************************************/


- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
  NSLog(@"item name = %@", item.title);
  NSInteger index = [self.tabBar.items indexOfObject:item];
  [self animationWithIndex:index];
  if([item.title isEqualToString:@"发现"]){
    NSLog(@"你正在发现有趣的东西");
  }
}
- (void)animationWithIndex:(NSInteger) index {
  
  NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
  for (UIView *tabBarButton in self.tabBar.subviews) {
    if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
      [tabbarbuttonArray addObject:tabBarButton];
    }
  }
  CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
  pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  pulse.duration = 0.2;
  pulse.repeatCount= 1;
  pulse.autoreverses= YES;
  pulse.fromValue= [NSNumber numberWithFloat:0.7];
  pulse.toValue= [NSNumber numberWithFloat:1.3];
  [[tabbarbuttonArray[index] layer] addAnimation:pulse forKey:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

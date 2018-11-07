//
//  BaseNavigationVC.m
//  YiLive
//
//  Created by Zhenglj on 2018/10/22.
//  Copyright © 2018年 郑吕杰. All rights reserved.
//

#import "BaseNavigationVC.h"

@interface BaseNavigationVC ()

@end

@implementation BaseNavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];
  if([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]){
  if(IS_IOS6){
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bar_ios6.png"] forBarMetrics:UIBarMetricsDefault];
  }else{
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg_png"] forBarMetrics:UIBarMetricsDefault];
  }
 }
  //导航栏
  UIButton *setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  setBtn.frame = CGRectMake(0, 0, 10, 19);
  [setBtn setBackgroundImage:[UIImage imageNamed:@"导航栏图标"] forState:UIControlStateNormal];
  [setBtn addTarget:self action:@selector(popToBack) forControlEvents:UIControlEventTouchUpInside];
  UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:setBtn];
  self.navigationItem.leftBarButtonItem = leftItem;
  
  if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
   {
    self.edgesForExtendedLayout = UIRectEdgeNone;
   }
  
}
//返回上一层
-(void)popToBack{
  [self popViewControllerAnimated:YES];
}
//跳转到下一层
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
  if (self.viewControllers.count > 0) {
    viewController.hidesBottomBarWhenPushed = YES;
  }
  [super pushViewController:viewController animated:animated];
}
//切换动画
- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
  return [super popViewControllerAnimated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//自应转
- (BOOL)shouldAutorotate {
  return YES;
}
//设置支持的屏幕旋转方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
  return self.interfaceOrientationMask;
}
//设置presentation方式展示的屏幕方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
  return self.interfaceOrientation;
}

@end

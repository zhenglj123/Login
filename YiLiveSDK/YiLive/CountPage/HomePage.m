//
//  HomePage.m
//  YiLive
//
//  Created by Zhenglj on 2018/10/11.
//  Copyright © 2018年 郑吕杰. All rights reserved.
//


#import "HomePage.h"
#import "AppDelegate.h"
#import "JScallOC.h"
@interface HomePage ()


@end

@implementation HomePage

//强制定向景观
-(void)forceOrientationLandscape{
  AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
  appdelegate.allowRotation = 1;
  [appdelegate application:[UIApplication sharedApplication] supportedInterfaceOrientationsForWindow:self.view.window];
}

- (void)viewDidLoad {
    [super viewDidLoad];
  self.title = @"首页";
  self.view.backgroundColor = [UIColor whiteColor];
  
  UIButton *aliButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  aliButton .frame = CGRectMake(20, 100, 120, 40);
  [aliButton  setTitle:@"支付宝支付" forState:UIControlStateNormal];
  [aliButton  addTarget:self action:@selector(aliClick) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:aliButton ];
  
  UIButton *wxButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  wxButton.frame = CGRectMake(20, 135, 100, 40);
  [wxButton setTitle:@"微信支付" forState:UIControlStateNormal];
  [wxButton addTarget:self action:@selector(wxClick) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:wxButton];
  
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

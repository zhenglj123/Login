//
//  PlusPage.m
//  YiLive
//
//  Created by Zhenglj on 2018/10/22.
//  Copyright © 2018年 郑吕杰. All rights reserved.
//

#import "PlusPage.h"

@interface PlusPage ()

@end

@implementation PlusPage

- (void)viewDidLoad {
    [super viewDidLoad];
  self.view.backgroundColor = [UIColor cyanColor];
  [self setupNavigationBarBack];
}

-(void)viewWillAppear:(BOOL)animated{
  [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bar_ios6"] forBarMetrics:UIBarMetricsDefault];
  [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

//在页面消失的时候就让navigationbar还原样式
-(void)viewWillDisappear:(BOOL)animated{
  
  [super viewDidDisappear:animated];
  [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
  [self.navigationController.navigationBar setShadowImage:nil];
  
}

#pragma mark -初始化导航栏

- (void)setupNavigationBarBack {
  
  UIButton *leftButton = [[UIButton alloc] init];
  leftButton.frame = CGRectMake(0, 0, 12, 21);
  leftButton.adjustsImageWhenHighlighted = NO;
  [leftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
  [leftButton setImage:[UIImage imageNamed:@"导航栏图标"] forState:UIControlStateNormal];
  UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
  UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
  
  spaceItem.width = -7;
  
  self.navigationItem.leftBarButtonItems = @[spaceItem,leftButtonItem];
  
}

#pragma mark -导航栏返回按钮
- (void)backAction {
  
  [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

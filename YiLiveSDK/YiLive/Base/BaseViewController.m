//
//  BaseViewController.m
//  YiLive
//
//  Created by Zhenglj on 2018/10/22.
//  Copyright © 2018年 郑吕杰. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@property (nonatomic, retain) UIView* overlayView;
@property (nonatomic, retain) UIView* bgview;
@property (nonatomic, retain) UIActivityIndicatorView *loadingIndicator;
@property (nonatomic, retain) UIImageView *loadingImageView;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  if (IS_IOS6) {
    self.automaticallyAdjustsScrollViewInsets = NO;
  }
  self.view.backgroundColor = [UIColor whiteColor];
 // 导航栏返回 按钮 打开注释掉的代码正常使用
      NSArray *viewControllers = self.navigationController.viewControllers;
      if (viewControllers.count > 1){
  
  [self.navigationItem setHidesBackButton:NO animated:NO];
  UIBarButtonItem *leftBarButtonItem = [ControlFactory createBackBarButtonItemWithTarget:self action:@selector(backAction)];
  if (IS_IOS6) {
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -15;
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, leftBarButtonItem];
    
  }else{
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
  }
  UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backSweepGesture:)];
  
  gesture.direction = UISwipeGestureRecognizerDirectionRight;
  [self.view addGestureRecognizer:gesture];
  // 导航栏返回 按钮 打开注释掉的代码正常使用
      }else{
          [self.navigationItem setHidesBackButton:YES animated:NO];
      }
}

- (void)backSweepGesture:(UISwipeGestureRecognizer*)gesture{
  
      [self dismissViewControllerAnimated:YES completion:nil];
      // 导航栏返回 按钮 打开注释掉的代码正常使用
      [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark Action
- (void)backAction{
  
  
      [self dismissViewControllerAnimated:YES completion:nil];
      // 导航栏返回 按钮 打开注释掉的代码正常使用
      [self.navigationController popViewControllerAnimated:YES];
}

-(void)setCustomerTitle:(NSString *)title{
  
  UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
  titleLabel.text = title;
  titleLabel.textColor = [UIColor whiteColor];
  titleLabel.font = [UIFont systemFontOfSize:18];
  self.navigationItem.titleView = titleLabel;
  
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end

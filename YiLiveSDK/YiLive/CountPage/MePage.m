//
//  MePage.m
//  YiLive
//
//  Created by Zhenglj on 2018/10/10.
//  Copyright © 2018年 郑吕杰. All rights reserved.
//

#import "MePage.h"
#import "Login.h"
#import "Comfirm.h"

@interface MePage ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationBarDelegate>{

 UIView *bgView;//背景图片
}
@property (nonatomic, strong)UIButton *head;//头像
@end

@implementation MePage

- (void)viewDidLoad {
    [super viewDidLoad];
  self.title = @"设置";
  self.view.backgroundColor = [UIColor whiteColor];
  
  UIButton *quietButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  quietButton.frame = CGRectMake(365, 80, 40, 30);
  quietButton.backgroundColor = [UIColor redColor];
  [quietButton setTitle:@"退出" forState:UIControlStateNormal];
  [quietButton addTarget:self action:@selector(quietClick) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:quietButton];
  
  UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  loginButton.frame = CGRectMake(305, 80, 40, 30);
  loginButton.backgroundColor = [UIColor greenColor];
  [loginButton setTitle:@"登入" forState:UIControlStateNormal];
  [loginButton addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:loginButton];
  
  UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  infoButton.frame = CGRectMake(20, 200, KScreen_Width-40, 40);
  infoButton.backgroundColor = [UIColor cyanColor];
  [infoButton setTitle:@"修改个人资料" forState:UIControlStateNormal];
  [infoButton addTarget:self action:@selector(infoClick) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:infoButton];
}

//退出按钮
- (void)quietClick{
  NSUserDefaults *sDefaults = [NSUserDefaults standardUserDefaults];
  [sDefaults removeObjectForKey:@"phone"];
  [sDefaults removeObjectForKey:@"pwd"];
  NSLog(@"清除用户账号密码：%@",sDefaults);
  [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)loginClick{
  Login *log = [[Login alloc]init];
  [self presentViewController:log animated:YES completion:nil];
}

-(void)infoClick{
  
  Comfirm *com = [[Comfirm alloc]init];
  [self.navigationController pushViewController:com animated:YES];
//  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"冬天到了，请添衣加裳" preferredStyle:UIAlertControllerStyleAlert];
//  [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//    [self.navigationController popViewControllerAnimated:YES]; //这里写选择确定之后的操作
//  }]];
//  [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//    NSLog(@"用户选择继续");  //这里写选择取消之后的操作
//  }]];
//[self presentViewController:alert animated:YES completion:nil];
 [self getUserInfo];
  
}

//取出用户信息
-(void)getUserInfo{
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  NSString *Phone = [userDefaults objectForKey:@"Phone"];
  NSString *Pwd = [userDefaults objectForKey:@"Pwd"];
  NSString *Name = [userDefaults objectForKey:@"Name"];
  NSString *Sex = [userDefaults objectForKey:@"Sex"];
  NSString *Age = [userDefaults objectForKey:@"Age"];
  NSString *Province = [userDefaults objectForKey:@"Province"];
  //Data格式转换图片格式取
  NSData *imageData = [userDefaults dataForKey:@"Image"];
  UIImage *image = [UIImage imageWithData:imageData];
  NSLog(@"取出用户信息:1 = %@, 2 = %@, 3 = %@, 4 = %@, 5 = %@, 6 = %@, 7 = %@",Phone,Pwd,Name,Sex,Age,Province,image);
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end

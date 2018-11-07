//
//  Comfirm.m
//  YiLive
//
//  Created by Zhenglj on 2018/10/23.
//  Copyright © 2018年 郑吕杰. All rights reserved.
//

#import "Comfirm.h"
#import "login.h"

@interface Comfirm ()
@property (nonatomic, strong)NSUserDefaults *userDefaults;
@end

@implementation Comfirm


- (void)viewDidLoad {
    [super viewDidLoad];
    [self phonePwd];
  self.title = @"个人信息确认";
  self.navigationController.navigationBarHidden = NO;
  
  [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
  self.view.backgroundColor=[UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1];
  UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(popClick)];
  [addBtn setImage:[UIImage imageNamed:@"导航栏图标"]];
  [addBtn setImageInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
  addBtn.tintColor=[UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1];
  [self.navigationItem setLeftBarButtonItem:addBtn];
  
  self.view.backgroundColor = [UIColor whiteColor];
  UIButton *goToLoginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  goToLoginButton.frame = CGRectMake(20, 540, KScreen_Width-40,50);
  goToLoginButton.backgroundColor = [UIColor cyanColor];
  [goToLoginButton setTitle:@"确认信息" forState:UIControlStateNormal];
  goToLoginButton.titleLabel.font = [UIFont systemFontOfSize:17.0f];
  goToLoginButton.layer.cornerRadius=5.0f;
  [goToLoginButton addTarget:self action:@selector(goToLoginClick) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:goToLoginButton];
  
  //用户注册传过来的值
  NSString *phoneN = [NSString stringWithFormat:@"%@",_phoneN];
  NSString *pwdN = [NSString stringWithFormat:@"%@",_pwdN];
  NSString *nickname = [NSString stringWithFormat:@"%@",_nickName];
  NSString *sex = [NSString stringWithFormat:@"%@",_sex];
  NSString *borth = [NSString stringWithFormat:@"%@",_borth];
  NSString *province = [NSString stringWithFormat:@"%@",_province];
  //循环创建TextField
  NSArray *textArray = @[phoneN,pwdN,nickname,sex,borth,province];
  for (int i = 0; i<6; i++) {
    UITextField *text = [[UITextField alloc]init];
    [text setText:textArray[i]];
    text.frame = CGRectMake(120, 100+i*35+i*25, KScreen_Width-160, 40);
    text.backgroundColor = [UIColor whiteColor];
    text.tag = i;
    [self.view addSubview:text];
  }
    
  NSArray *labelArray = @[@"手机号:",@"密码:",@"姓名:",@"性别:",@"生日:",@"省份:"];
  for (int t = 0; t<6; t++) {
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(20, 100+t*35+t*25, 65, 40);
    [label setText:labelArray[t]];
    label.backgroundColor = [UIColor whiteColor];
    label.tag = t;
    [self.view addSubview:label];
  }
}

-(void)popClick
{
  [self.navigationController popViewControllerAnimated:YES];
}

-(void)goToLoginClick{
  [self saveUserInfo];
  [self.navigationController pushViewController:[[Login alloc]init] animated:YES];
 
}
//取出用户UID
-(void)phonePwd{
   _userDefaults = [NSUserDefaults standardUserDefaults];
  NSUserDefaults *phoneV = [_userDefaults objectForKey:@"phone"];
  NSUserDefaults *pwdV = [_userDefaults objectForKey:@"pwd"];
  _phoneN = phoneV;
  _pwdN = pwdV;
  NSLog(@"个人用户手机号:%@ \n 个人用户密码:%@",_phoneN,_pwdN);
}

//存储用户信息
-(void)saveUserInfo{
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  [userDefaults removeObjectForKey:@"Phone"];
  [userDefaults removeObjectForKey:@"pwd"];
  [userDefaults setObject:_nickName forKey:@"Name"];
  [userDefaults setObject:_sex forKey:@"Sex"];
  [userDefaults setObject:_borth forKey:@"Age"];
  [userDefaults setObject:_province forKey:@"Province"];
  //图片转换Data格式储存
  UIImage *image = [UIImage imageNamed:@"head"];
  NSData *imageData = UIImageJPEGRepresentation(image, 100);
  [userDefaults setObject:imageData forKey:@"Image"];
  [userDefaults synchronize];
   NSLog(@"用户的信息:%@",userDefaults);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

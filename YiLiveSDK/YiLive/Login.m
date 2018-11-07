//
//  Login.m
//  YiLive
//
//  Created by Zhenglj on 2018/10/10.
//  Copyright © 2018年 郑吕杰. All rights reserved.
//

#import "Login.h"
#import "ForgetPwd.h"
#import "Register.h"
#import "TabBarViewController.h"
#import "TabBarTwo.h"



@interface Login ()<UITextFieldDelegate>
{
  UIImageView *view;
  UIView *backgroundView;
  UITextField *passWord;
  UITextField *phoneNum;
  UIButton *QQBtn;
  UIButton *WeChatBtn;
  UIButton *SinaBtn;
}
@property (nonatomic,strong) NSUserDefaults *userDefaults;
@end

@implementation Login


//视图即将出现，判断是否为自动登录
-(void)viewWillAppear:(BOOL)animated{
    //全局初始化
    _userDefaults = [NSUserDefaults standardUserDefaults];

    NSString *phone = [_userDefaults objectForKey:@"phone"];
    NSString *pwd = [_userDefaults objectForKey:@"pwd"];
    if (pwd.length>0) {//自动登录
        
        TabBarTwo *tabbar = [[TabBarTwo alloc]init];
        [self presentViewController:tabbar animated:YES completion:nil];

    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
  self.hidesBottomBarWhenPushed = NO;
  self.navigationController.navigationBarHidden = YES;
  //设置NavigationBar背景颜色
  view=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    view.image=[UIImage imageNamed:@"YiLive"];
  [self.view addSubview:view];
    
    
  //登入标签
  UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width-30)/2, 30, 50, 30)];
  label.text=@"登录";
  label.textColor=[UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1];
  [self.view addSubview:label];
  
  //具体方法写在类里，这里实现
  [self createButtons];
  [self createImageViews];
  [self createTextFields];
  [self createLabel];
  
  //单击空白区域退出键盘
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeKeyboard:)];
  tap.numberOfTapsRequired = 1;
  tap.numberOfTouchesRequired = 1;
  [self.view addGestureRecognizer:tap];
  
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
  NSLog(@"手机号：%@",string);
  
 // NSString *tobestring = [textField.text stringByReplacingCharactersInRange:range withString:string];
  
  if (range.location == 13) {
    return NO;
  }else if (range.location == 8){
    
    NSMutableString *str = [[NSMutableString alloc] initWithString:phoneNum.text];
    NSRange range = [str rangeOfString:@"-"];
    if (range.location!=NSNotFound)
     {
     }else {
       [str insertString:@"-" atIndex:3];
       [str insertString:@"-" atIndex:8];
       phoneNum.text = str;
     }
    return YES;
  }else if(range.location==9) {
    NSMutableString *str = [[NSMutableString alloc] initWithString:phoneNum.text];
    NSString *str1;
    str1 = [str stringByReplacingOccurrencesOfString:@"-"withString:@""];
    phoneNum.text = str1;
    return YES;
    
  }else
   {
    return YES;
   }

}
//创建标签
-(void)createLabel
{
  UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width-140)/2, 390, 140, 21)];
  label.text=@"第三方账号快速登录";
  label.textColor=[UIColor grayColor];
  label.textAlignment=UITextAlignmentCenter;
  label.font=[UIFont systemFontOfSize:14];
  [self.view addSubview:label];
}
//创建输入框
-(void)createTextFields
{
  CGRect frame=[UIScreen mainScreen].bounds;
  backgroundView=[[UIView alloc]initWithFrame:CGRectMake(10, 75, frame.size.width-20, 100)];
  backgroundView.layer.cornerRadius=3.0;
  backgroundView.alpha=0.7;
  backgroundView.backgroundColor=[UIColor whiteColor];
  [self.view addSubview:backgroundView];
  
  phoneNum = [self createTextFielfFrame:CGRectMake(60, 10, 271, 30) font:[UIFont systemFontOfSize:14] placeholder:@"请输入您手机号码"];
  phoneNum.text= @"";
  phoneNum.delegate = self;//代理textField
  phoneNum.keyboardType=UIKeyboardTypeNumberPad;
  phoneNum.clearButtonMode = UITextFieldViewModeWhileEditing;
  
  passWord=[self createTextFielfFrame:CGRectMake(60, 60, 271, 30) font:[UIFont systemFontOfSize:14]  placeholder:@"密码" ];
  passWord.clearButtonMode = UITextFieldViewModeWhileEditing;
  passWord.text= @"";
  //密文样式
  passWord.secureTextEntry=YES;
  passWord.keyboardType=UIKeyboardTypeNumberPad;
  
  
  UIImageView *usernameImageView=[self createImageViewFrame:CGRectMake(20, 10, 25, 25) imageName:@"用户图标" color:nil];
  UIImageView *passWordImageView=[self createImageViewFrame:CGRectMake(20, 60, 25, 25) imageName:@"密码图标" color:nil];
  UIImageView *line1=[self createImageViewFrame:CGRectMake(20, 50, backgroundView.frame.size.width-40, 1) imageName:nil color:[UIColor colorWithRed:180/255.0f green:180/255.0f blue:180/255.0f alpha:.3]];
  
  [backgroundView addSubview:phoneNum];
  [backgroundView addSubview:passWord];
  
  [backgroundView addSubview:usernameImageView];
  [backgroundView addSubview:passWordImageView];
  [backgroundView addSubview:line1];
}



//触摸结束
-(void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{ //重新签名第一响应
  [phoneNum resignFirstResponder];
  [passWord resignFirstResponder];
}
//键盘取消事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  [phoneNum resignFirstResponder];
  [passWord resignFirstResponder];
  NSLog(@"alex-取消键盘");
  [self.view endEditing:YES];
}
//创建图片视图
-(void)createImageViews{

  UIImageView *line1=[self createImageViewFrame:CGRectMake(2, 400, 100, 1) imageName:nil color:[UIColor lightGrayColor]];
  UIImageView *line2=[self createImageViewFrame:CGRectMake(self.view.frame.size.width-100-4, 400, 100, 1) imageName:nil color:[UIColor lightGrayColor]];

          [self.view addSubview:line1];
          [self.view addSubview:line2];
}
//创建按钮
-(void)createButtons
{
  UIButton *landBtn=[self createButtonFrame:CGRectMake(10, 190, KScreen_Width-20, 37) backImageName:nil title:@"登录" titleColor:[UIColor whiteColor]  font:[UIFont systemFontOfSize:19] target:self action:@selector(landClick)];
  landBtn.backgroundColor=[UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1];
  landBtn.layer.cornerRadius=5.0f;
  
  UIButton *newUserBtn=[self createButtonFrame:CGRectMake(10, 235, 100, 35) backImageName:@"tabbarbg" title:@"快速注册" titleColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] target:self action:@selector(registration:)];
  
  
  UIButton *forgotPwdBtn=[self createButtonFrame:CGRectMake(self.view.frame.size.width-115, 235, 100, 35)  backImageName:@"tabbarbg" title:@"找回密码" titleColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] target:self action:@selector(fogetPwd:)];
  
  
  
#define Start_X 60.0f           // 第一个按钮的X坐标
#define Start_Y 440.0f           // 第一个按钮的Y坐标
#define Width_Space 50.0f        // 2个按钮之间的横间距
#define Height_Space 20.0f      // 竖间距
#define Button_Height 50.0f    // 高
#define Button_Width 50.0f      // 宽
  
  
  
  //微信
  WeChatBtn=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-50)/2, 440, 50, 50)];
  //WeChatBtn.tag = UMSocialSnsTypeWechatSession;
  WeChatBtn.layer.cornerRadius=25;
  WeChatBtn=[self createButtonFrame:WeChatBtn.frame backImageName:@"微信Logo" title:nil titleColor:nil font:nil target:self action:@selector(onClickWX:)];
  //QQ
  QQBtn=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-50)/2-100, 440, 50, 50)];
  //QQBtn.tag = UMSocialSnsTypeMobileQQ;
  QQBtn.layer.cornerRadius=25;
  QQBtn=[self createButtonFrame:QQBtn.frame backImageName:@"QQLogo" title:nil titleColor:nil font:nil target:self action:@selector(onClickQQ:)];
  
  //新浪微博
  SinaBtn=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-50)/2+100, 440, 50, 50)];
  //xinlangBtn.tag = UMSocialSnsTypeSina;
  SinaBtn.layer.cornerRadius=25;
  SinaBtn=[self createButtonFrame:SinaBtn.frame backImageName:@"微博Logo" title:nil titleColor:nil font:nil target:self action:@selector(onClickSina:)];
  
  [self.view addSubview:WeChatBtn];
  [self.view addSubview:QQBtn];
  [self.view addSubview:SinaBtn];
  [self.view addSubview:landBtn];
  [self.view addSubview:newUserBtn];
  [self.view addSubview:forgotPwdBtn];
  
  
}


- (void)onClickQQ:(UIButton *)button
{
  NSLog(@"你未安装QQ");
  if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]){
      QQBtn.hidden = YES;
  }
}

- (void)onClickWX:(UIButton *)button
{
  NSLog(@"你未安装微信");
  if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]){
    WeChatBtn.hidden = YES;
  }
}

- (void)onClickSina:(UIButton *)button
{
  NSLog(@"你未安装微博");
  if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"Sinaweibo://"]]){
    SinaBtn.hidden = YES;
  }
}

//退出键盘
- (void)closeKeyboard:(id)sender{
  [self.view endEditing:YES];
}

//输入文本框
-(UITextField *)createTextFielfFrame:(CGRect)frame font:(UIFont *)font placeholder:(NSString *)placeholder
{
  UITextField *textField=[[UITextField alloc]initWithFrame:frame];
  
  textField.font=font;
  
  textField.textColor=[UIColor grayColor];
  
  textField.borderStyle=UITextBorderStyleNone;
  
  textField.placeholder=placeholder;
  
  return textField;
}
//创建图像框架
-(UIImageView *)createImageViewFrame:(CGRect)frame imageName:(NSString *)imageName color:(UIColor *)color
{
  UIImageView *imageView=[[UIImageView alloc]initWithFrame:frame];
  
  if (imageName)
   {
    imageView.image=[UIImage imageNamed:imageName];
   }
  if (color)
   {
    imageView.backgroundColor=color;
   }
  
  return imageView;
}
//创建按钮框架
-(UIButton *)createButtonFrame:(CGRect)frame backImageName:(NSString *)imageName title:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font target:(id)target action:(SEL)action
{
  UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
  btn.frame=frame;
  if (imageName)
   {
    [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
   }
  
  if (font)
   {
    btn.titleLabel.font=font;
   }
  
  if (title)
   {
    [btn setTitle:title forState:UIControlStateNormal];
   }
  if (color)
   {
    [btn setTitleColor:color forState:UIControlStateNormal];
   }
  if (target&&action)
   {
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
   }
  return btn;
}

//登入实现方法
-(void)landClick{
  
  if ([phoneNum.text isEqualToString:@""])
   {
     NSLog(@"亲,请输入用户名");
    //[MBProgressHUD showInfoWithStatus:@"亲,请输入用户名"];
    return;
    //[MBProgressHUD dismiss];
   }
  else if (phoneNum.text.length == 10)
   {
   // [MBProgressHUD showInfoWithStatus:@"亲,请输入的手机号码格式不正确"];
    NSLog(@"亲,您输入的手机号码格式不正确");
    return;
   }
  else if ([passWord.text isEqualToString:@""])
   {
    NSLog(@"亲,请输入密码");
    return;
   }
  else if (passWord.text.length <6)
   {
    
    NSLog(@"亲,密码长度至少六位");
    return;
   }
  
   BOOL  sds = [self phoneNumber:phoneNum.text];
 
  [self savecookie:phoneNum.text pwd:passWord.text];
  
  TabBarTwo *tabbar = [[TabBarTwo alloc]init];
  [self presentViewController:tabbar animated:YES completion:nil];
  
//    TabBarViewController *tabbar = [[TabBarViewController alloc]init];
//    [self presentViewController:tabbar animated:YES completion:nil];
  
    
}

#pragma mark - cookie 用户本地储存临时文件
-(void)savecookie:(NSString *)phone pwd:(NSString *)pwd{

  [_userDefaults setObject:phone forKey:@"phone"];
  [_userDefaults setObject:pwd forKey:@"pwd"];
  [_userDefaults synchronize];
  NSLog(@"用户登入的Cookie：%@",_userDefaults);
}

//手机号码验证
-(BOOL)phoneNumber:(NSString *)mobileNum{
  
  /**
   * 手机号码
   * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
   * 联通：130,131,132,152,155,156,185,186
   * 电信：133,1349,153,180,189
   */
  NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
  
  /**
   10         * 中国移动：China Mobile
   11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
   12         */
  NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
  
  /**
   15         * 中国联通：China Unicom
   16         * 130,131,132,152,155,156,175,176,185,186
   17         */
  NSString * CU = @"^1(3[0-2]|5[256]|7[56]|8[56])\\d{8}$";
  
  /**
   20         * 中国电信：China Telecom
   21         * 133,1349,153,177,180,189
   22         */
  NSString * CT = @"^1((33|53|77|8[09])[0-9]|349)\\d{7}$";
  
  /**
   25         * 大陆地区固话及小灵通
   26         * 区号：010,020,021,022,023,024,025,027,028,029
   27         * 号码：七位或八位
   28         */
  NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
  
  NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
  NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
  NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
  NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
  NSPredicate *regextestPHS = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
  
  if(([regextestmobile evaluateWithObject:mobileNum] == YES)
     || ([regextestcm evaluateWithObject:mobileNum] == YES)
     || ([regextestct evaluateWithObject:mobileNum] == YES)
     || ([regextestcu evaluateWithObject:mobileNum] == YES)
     || ([regextestPHS evaluateWithObject:mobileNum] == YES)){
    NSLog(@"联通、移动、电信、小联通及其其他开头的号码");
    return YES;
  }else{
    NSLog(@"联通、移动、电信、小联通及其其他号码格式错误");
    
    return NO;
  }
}

//注册页面跳转
-(void)registration:(UIButton *)button
{
  
  [self.navigationController pushViewController:[[Register alloc]init] animated:YES];
 // [self presentViewController:[[Register alloc]init] animated:NO completion:nil];
}
//忘记密码页面跳转
-(void)fogetPwd:(UIButton *)button
{
  [self.navigationController pushViewController:[[ForgetPwd alloc]init] animated:YES];
}

#pragma mark - 工具
//手机号格式化
-(NSString*)getHiddenStringWithPhoneNumber:(NSString*)number middle:(NSInteger)countHiiden{
  
  if (number.length<countHiiden) {
    return number;
  }
  NSInteger count=countHiiden;
  NSInteger leftCount=number.length/2-count/2;
  NSString *format=@"";
  for (int i=0; i<count; i++) {
    format=[NSString stringWithFormat:@"%@%@",format,@"*"];
  }
  
  NSString *handle=[number stringByReplacingCharactersInRange:NSMakeRange(leftCount, count) withString:format];
  // handle = [handle stringByReplacingCharactersInRange:NSMakeRange(number.length-count, count-leftCount) withString:format];
  
  return handle;
}

//手机号格式化后还原
-(NSString*)getHiddenStringWithPhoneNumber1:(NSString*)number middle:(NSInteger)countHiiden{
  if (number.length<countHiiden) {
    return number;
  }
  NSString *format=@"";
  for (int i=0; i<1; i++) {
    //format=[NSString stringWithFormat:@"%@",[CheckTools getUser]];
  }
  
  NSString *handle=[number stringByReplacingCharactersInRange:NSMakeRange(0, 0) withString:@""];
  //handle = [handle stringByReplacingCharactersInRange:NSMakeRange(number.length-count, count-leftCount) withString:format];
  
  return handle;
}


// 监听键盘事件
- (void)obseverKeyBoard
{
  //增加监听，当键盘出现或改变时收出消息
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillShow:)
                                               name:UIKeyboardWillShowNotification
                                             object:nil];
  
  //增加监听，当键退出时收出消息
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillHide:)
                                               name:UIKeyboardWillHideNotification
                                             object:nil];
  
}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
  //获取键盘的高度
  NSDictionary *userInfo = [aNotification userInfo];
  NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
  CGRect keyboardRect = [aValue CGRectValue];
  
  
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
  NSLog(@"KeyBoard退出");
 
}



//接收内存警告⚠️
- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  
}


@end

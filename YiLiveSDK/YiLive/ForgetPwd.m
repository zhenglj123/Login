//
//  ForgetPwd.m
//  YiLive
//
//  Created by Zhenglj on 2018/10/10.
//  Copyright © 2018年 郑吕杰. All rights reserved.
//

#import "ForgetPwd.h"
#import "Login.h"

@interface ForgetPwd ()<UITextFieldDelegate>
{
  UIView *bgView;
  UITextField *phone;
  UITextField *code;
  UITextField *newPwd;
  UINavigationBar *coust;
  UIButton *yzButton;
}
@property (nonatomic,copy) NSString *userPhoneNum;
@property (nonatomic, assign) NSInteger timeCount;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, copy) NSString *smsId;//验证码
@property (nonatomic, strong) UITextField *phone;
@property (nonatomic, strong)NSUserDefaults *userDefaults;
@end

@implementation ForgetPwd

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:YES];
  __weak typeof(self)weakSelf = self;
  dispatch_async(dispatch_get_main_queue(), ^{
    weakSelf.navigationItem.titleView.alpha = 0;
  });
}


- (void)viewDidLoad {
    [super viewDidLoad];
  self.navigationController.navigationBarHidden = NO;
 
  self.title = @"找回密码";
  self.view.backgroundColor = [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1];
  UIBarButtonItem *addBtn = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
  [addBtn setImage:[UIImage imageNamed:@"导航栏图标"]];
  [addBtn setImageInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
  addBtn.tintColor = [UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255/.0f alpha:1];
  [self.navigationItem setLeftBarButtonItem:addBtn];
  
  [self createTextFields];
  
  //单击空白区域退出键盘
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeKeyboard:)];
  tap.numberOfTapsRequired = 1;
  tap.numberOfTouchesRequired = 1;
  [self.view addGestureRecognizer:tap];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
  NSLog(@"注册手机号：%@",string);
  
  if (range.location == 13) {
    return NO;
  }else if (range.location == 8){
    
    NSMutableString *str = [[NSMutableString alloc] initWithString:phone.text];
    NSRange range = [str rangeOfString:@"-"];
    if (range.location!=NSNotFound)
     {
     }else {
       [str insertString:@"-" atIndex:3];
       [str insertString:@"-" atIndex:8];
       phone.text = str;
     }
    return YES;
  }else if(range.location==9) {
    NSMutableString *str = [[NSMutableString alloc] initWithString:phone.text];
    NSString *str1;
    str1 = [str stringByReplacingOccurrencesOfString:@"-"withString:@""];
    phone.text = str1;
    return YES;
  }else
   {
    return YES;
   }
}

-(void)backClick
{
  [self.navigationController popViewControllerAnimated:YES];
  
}

-(void)createTextFields
{
  //label背景颜色
  CGRect frame=[UIScreen mainScreen].bounds;
  bgView=[[UIView alloc]initWithFrame:CGRectMake(10, 110, frame.size.width-20, 150)];
  bgView.layer.cornerRadius=4.0;
  bgView.backgroundColor=[UIColor whiteColor];
  [self.view addSubview:bgView];
  
  UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(30, 75, self.view.frame.size.width-90, 30)];
  label.text=@"请输入您的手机号码";
  label.textColor=[UIColor grayColor];
  label.font=[UIFont systemFontOfSize:13];
  [self.view addSubview:label];
  
  UILabel *phonelabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 12, 50, 25)];
  phonelabel.text=@"手机号";
  phonelabel.textColor=[UIColor blackColor];
  phonelabel.font=[UIFont systemFontOfSize:14];
  phone=[self createTextFielfFrame:CGRectMake(100, 10, 200, 30) font:[UIFont systemFontOfSize:14] placeholder:@"11位手机号"];
  phone.text = @"";
  phone.delegate = self;//输入框代理
  phone.clearButtonMode = UITextFieldViewModeWhileEditing;
  phone.keyboardType=UIKeyboardTypeNumberPad;
  
  
  UILabel *codelabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 62, 50, 25)];
  codelabel.text=@"验证码";
  codelabel.textColor=[UIColor blackColor];
  codelabel.font=[UIFont systemFontOfSize:14];
  code=[self createTextFielfFrame:CGRectMake(100, 60, 90, 30) font:[UIFont systemFontOfSize:14]  placeholder:@"4位数字" ];
  code.clearButtonMode = UITextFieldViewModeWhileEditing;
  code.secureTextEntry=NO;  //星号输入
  code.keyboardType=UIKeyboardTypeNumberPad;
  
  UILabel *newPwdlabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 112, 50, 25)];
  newPwdlabel.text=@"新密码";
  newPwdlabel.textColor=[UIColor blackColor];
  newPwdlabel.font=[UIFont systemFontOfSize:14];
  newPwd=[self createTextFielfFrame:CGRectMake(100, 110, 200, 30) font:[UIFont systemFontOfSize:14] placeholder:@"6-20位字母或数字"];
  newPwd.text = @"";
  newPwd.clearButtonMode = UITextFieldViewModeWhileEditing;
  newPwd.secureTextEntry=YES;  //密文样式
  newPwd.keyboardType=UIKeyboardTypeNumberPad;
  
  yzButton=[[UIButton alloc]initWithFrame:CGRectMake(bgView.frame.size.width-100-20, 62, 130, 30)];
  [yzButton setTitle:@"获取验证码" forState:UIControlStateNormal];
  [yzButton setTitleColor:[UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1] forState:UIControlStateNormal];
  yzButton.font=[UIFont systemFontOfSize:15];
  [yzButton addTarget:self action:@selector(getValidCode:) forControlEvents:UIControlEventTouchUpInside];
  [bgView addSubview:yzButton];
  
  //线
  UIImageView *line1=[self createImageViewFrame:CGRectMake(20, 50, bgView.frame.size.width-40, 1) imageName:nil color:[UIColor colorWithRed:180/255.0f green:180/255.0f blue:180/255.0f alpha:.3]];
  UIImageView *line2=[self createImageViewFrame:CGRectMake(20, 100, bgView.frame.size.width-40, 1) imageName:nil color:[UIColor colorWithRed:180/255.0f green:180/255.0f blue:180/255.0f alpha:.3]];
  
  
  UIButton *landBtn=[self createButtonFrame:CGRectMake(10, bgView.frame.size.height+bgView.frame.origin.y+25,self.view.frame.size.width-20, 37) backImageName:nil title:@"完成" titleColor:[UIColor whiteColor]  font:[UIFont systemFontOfSize:17] target:self action:@selector(newPwdClick)];
  landBtn.backgroundColor=[UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1];
  landBtn.layer.cornerRadius=5.0f;
  
  
  [bgView addSubview:phone];
  [bgView addSubview:code];
  [bgView addSubview:newPwd];
  
  [bgView addSubview:phonelabel];
  [bgView addSubview:codelabel];
  [bgView addSubview:newPwdlabel];
  [bgView addSubview:line1];
  [bgView addSubview:line2];
  [self.view addSubview:landBtn];
  
}

- (void)getValidCode:(UIButton *)sender
{
  //没有接口打开点击不了获取验证码
  //  if ([phone.text isEqualToString:@""])
  //   {
  //        NSLog(@"亲，请输入手机号码");
  //    return;
  //   }
  //  else if (phone.text.length <11)
  //   {
  //        NSLog(@"您输入的手机号码格式不正确");
  //    return;
  //   }
  _userPhoneNum =phone.text;
  sender.userInteractionEnabled = NO;
  self.timeCount = 60;
   __weak ForgetPwd *weakSelf = self;
  self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reduceTime:) userInfo:sender repeats:YES];
  
}

- (void)reduceTime:(NSTimer *)codeTimer {
  self.timeCount--;
  if (self.timeCount == 0) {
    [yzButton setTitle:@"重新获取验证码" forState:UIControlStateNormal];
    [yzButton setTitleColor:[UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1] forState:UIControlStateNormal];
    UIButton *info = codeTimer.userInfo;
    info.enabled = YES;
    yzButton.userInteractionEnabled = YES;
    [self.timer invalidate];
  } else {
    NSString *str = [NSString stringWithFormat:@"%lu秒后重新获取", self.timeCount];
    [yzButton setTitle:str forState:UIControlStateNormal];
    yzButton.userInteractionEnabled = NO;
    
  }
}

//退出键盘
- (void)closeKeyboard:(id)sender{
  [self.view endEditing:YES];
}

//触摸结束
-(void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{ //重新签名第一响应
  [phone resignFirstResponder];
  [newPwd resignFirstResponder];
}
//键盘取消事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  [phone resignFirstResponder];
  [newPwd resignFirstResponder];
  NSLog(@"alex-取消键盘");
  [self.view endEditing:YES];
}

-(UITextField *)createTextFielfFrame:(CGRect)frame font:(UIFont *)font placeholder:(NSString *)placeholder
{
  UITextField *textField=[[UITextField alloc]initWithFrame:frame];
  
  textField.font=font;
  
  textField.textColor=[UIColor grayColor];
  
  textField.borderStyle=UITextBorderStyleNone;
  
  textField.placeholder=placeholder;
  
  return textField;
}

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


-(void)newPwdClick
{
      if ([phone.text isEqualToString:@""])
      {
          //[MBProgressHUD showInfoWithStatus:@"亲,请输入注册手机号码"];
       NSLog(@"亲,请输入注册手机号码");
          return;
      }
      else if (phone.text.length <11)
      {
         // [MBProgressHUD showInfoWithStatus:@"您输入的手机号码格式不正确"];
        NSLog(@"您输入的手机号码格式不正确");
          return;
      }
      else if([newPwd.text isEqualToString:@""])
      {
       NSLog(@"亲，请输入密码");
          return;
      }
      else if (newPwd.text.length <6)
       {
        NSLog(@"您输入大于6位数密码");
          return;
       }
      else if ([code.text isEqualToString:@""])
       {
        NSLog(@"亲,请输入验证码");
        return;
       }
  //      else if (self.smsId.length == 0)
  //      {//验证码校验
  //         NSLog(@"验证码错误");
  //          return;
  //     }
  NSLog(@"新密码：%@",newPwd.text);
  [self.navigationController pushViewController:[[Login alloc]init] animated:YES];
}

#pragma mark - cookie 用户本地储存临时文件
-(void)cookie:(NSString *)phone pwd:(NSString *)newPwd{
  
  [_userDefaults setObject:phone forKey:@"phone"];
  [_userDefaults setObject:newPwd forKey:@"pwd"];
  [_userDefaults synchronize];
  NSLog(@"用户修改密码后的的Cookie：%@",_userDefaults);
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


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  
}




@end

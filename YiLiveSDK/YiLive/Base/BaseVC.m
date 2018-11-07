//
//  BaseVC.m
//  YiLive
//
//  Created by Zhenglj on 2018/10/22.
//  Copyright © 2018年 郑吕杰. All rights reserved.
//

#import "BaseVC.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import <MobileCoreServices/MobileCoreServices.h>


@interface BaseVC ()

@end

@implementation BaseVC

-(void)viewWillAppear:(BOOL)animated{
  [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
  [super viewWillAppear:animated];
  if(isCheckConnection){
    //检测网络通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkNetWork:)name:@"HTHttpNotConnectedToInternerIdentifier" object:nil];
     NSLog(@"没网络链接");
  }
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userInfoNotification:)name:@"userInfoNotification" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
  [super viewWillDisappear:animated];
  /*去掉检测网络通知*/
  [[NSNotificationCenter defaultCenter] removeObserver:self name:@"HTHttpNotConnectedToInternetIdentifer" object:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self name:@"HTViewcontrollerNotificationFailureRefreshIdentifer" object:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self name:@"userInfoNotification" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
  [self.navigationController.navigationBar setShadowImage:[self imageWithColor:[UIColor whiteColor]]];
  [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
  
  self.view.backgroundColor = [UIColor lightGrayColor];
  [self customBackBtn];
  [self customBarTitle];
  [self hideEmpthView];
  
  /*添加登录成功注册通知*/
  [[NSNotificationCenter defaultCenter]
   addObserver:self
  selector:@selector(loginSuccess:)name:@"HTViewcontrollerNotificationSuccessRefreshIdentifer"
   object:nil];
  
  //开启ios右滑返回
  if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
  }
}
//首选状态栏样式
- (UIStatusBarStyle)preferredStatusBarStyle {
  return UIStatusBarStyleDefault;
}
- (void)checkConncetion{
  NSLog(@"检查链接");
}
- (void)reloadButtonAction:(UIButton *)sender{
  int tag = 0;
  NSAssert(tag = 0, @"添加检查网络状态的方法时，需要重写reloadButtonAction方法");
}
//内存通知警告
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   [[NSNotificationCenter defaultCenter] removeObserver:self name:@"HTViewcontrollerNotificationSuccessRefreshIdentifer" object:nil];
}
//显示空视图
- (void)showEmptyView:(NSString *)str WithImage:(UIImage *)img WithPosition:(CGPoint)pos createBtn:(BOOL)yesNo{
  if (!isShownEmpty) {
    UIView *_emptyLabel = [[UIView alloc]init];
    
    [_emptyLabel setFrame:CGRectMake(0,0, KScreen_Width, KScreen_Height)];
    [_emptyLabel setTag:80000];
    [_emptyLabel setBackgroundColor:[UIColor whiteColor]];
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(HTScreenWidth / 2 - img.size.width / 2, pos.y+100, img.size.width, img.size.height)];
    [imgView setImage:img];
    [_emptyLabel addSubview:imgView];
    
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(HTScreenWidth / 2 - 140, imgView.frame.origin.y + imgView.frame.size.height + 15, 280, 20)];
    textLabel.text = str;
    [textLabel setFont:[UIFont systemFontOfSize:15.0f]];
    textLabel.textAlignment = NSTextAlignmentCenter;
    [textLabel setTextColor:RGB(146, 147, 148)];
    [_emptyLabel addSubview:textLabel];
    
    if (yesNo) {
      //加载按钮
      UIButton *reloadBtn = [[UIButton alloc]initWithFrame:CGRectMake(HTScreenWidth / 2 - 80, textLabel.frame.origin.y + 30 ,160, 45)];
      reloadBtn.layer.cornerRadius = 2.5f;
      [reloadBtn addTarget:self action:@selector(emptyButtonAction:) forControlEvents:UIControlEventTouchUpInside];
      [reloadBtn setBackgroundColor:[UIColor redColor]];
      [reloadBtn setTitle:@" " forState:UIControlStateNormal];
      [_emptyLabel addSubview:reloadBtn];
    }
    [self.view addSubview:_emptyLabel];
    [self.view bringSubviewToFront:_emptyLabel];
    isShownEmpty = YES;
  }
}
- (void)emptyButtonAction:(UIButton *)btn{
  NSLog(@"空视图按钮动作");
}
//隐藏空视图
- (void)hideEmpthView
{
  isShownEmpty = NO;
  for (UIView *view in self.view.subviews) {
    if (view.tag == 80000) {
      [view removeFromSuperview];
    }
  }
}

/*自定义后退按钮*/
- (void)customBackBtn
{
  UIImage *backImg = [UIImage imageNamed:@"back"];
  backImg = [backImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
  UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:backImg style:UIBarButtonItemStylePlain target:self action:@selector(btnBackClicked:) ];
  self.navigationItem.leftBarButtonItem = item;
}
//自定义标题
- (void)customBarTitle
{
  [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:18.0f],NSFontAttributeName,nil]];
}
//返回按钮
-(void)btnBackClicked:(id)sender
{
  [self.view endEditing:YES];
  [self.navigationController popViewControllerAnimated:YES];
}
//分享
-(void)btnShareClicked:(id)sender
{
  [self.view endEditing:YES];
}
#pragma mark - Notification
/**
 *  覆盖方法，登录成功刷新数据
 *
 *  @param notification notification
 */
- (void)loginSuccess:(NSNotification *)notification
{
  if([notification.name isEqualToString:@"HTViewcontrollerNotificationSuccessRefreshIdentifer"])
   {
    NSLog(@"登入成功刷新数据");
   }
}

/**
 *  检查网络
 *
 *  @param notification notification
 */
- (void)checkNetWork:(NSNotification *)notification
{
  if([notification.name isEqualToString:@"HTHttpNotConnectedToInternetIdentifer"])
   {
    if([[[notification userInfo] objectForKey:@"HTNetWork"] boolValue]){
      //            [AppDelegate shareAppDelegate].isConnect = YES;//分享链接打开
    }else{
      NSLog(@"检查网络");
      //            [AppDelegate shareAppDelegate].isConnect = NO;//分享链接关闭
    }
    [self checkConncetion];
   }
}
//上一版本更新视图
- (void)popVersionUpdateView:(NSString *)msg
{
  CGSize aFactSize = [[UIScreen mainScreen] bounds].size;
  UIView *bgView = [self.tabBarController.view viewWithTag:20001];
  if(!bgView){
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, aFactSize.width, aFactSize.height)];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.f;
    bgView.tag = 20001;
    [self.tabBarController.view addSubview:bgView];
  }
  
  UIView *adView = [self.tabBarController.view viewWithTag:20002];
  NSString *str = msg;
  
  if(!adView){
    
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"VersionUpdateView" owner:self options:nil];
    adView = [nib objectAtIndex:0];
    adView.tag = 20002;
    
    UILabel *nameLabel = (UILabel *)[adView viewWithTag:1002];
    adView.layer.cornerRadius = 6;
    [self.tabBarController.view addSubview:adView];
    
    CGFloat screenWidth = HTScreenWidth;
    switch ((int)screenWidth) {
        /*
         */
      case 414:
     {
      
      nameLabel.font = [UIFont systemFontOfSize:14.f];
      CGRect tmpRect = [str boundingRectWithSize:CGSizeMake(260, CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14.f],NSFontAttributeName, nil]
                                         context:nil];
      
      CGFloat tmpHeight = tmpRect.size.height+140;
      
      adView.frame = CGRectMake((HTScreenWidth-adView.frame.size.width-40)/2, (HTScreenHeight-tmpHeight)/2, adView.frame.size.width+40, tmpHeight);
     }
        break;
      default:{
        CGRect tmpRect = [str boundingRectWithSize:CGSizeMake(220, CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:[NSDictionary dictionaryWithObjectsAndKeys:nameLabel.font,NSFontAttributeName, nil]
                                           context:nil];
        
        CGFloat tmpHeight = tmpRect.size.height+140;
        adView.frame = CGRectMake((HTScreenWidth-adView.frame.size.width)/2, (HTScreenHeight-tmpHeight)/2, adView.frame.size.width, tmpHeight);
        
      }
        break;
    }
  }
  adView.backgroundColor = [UIColor whiteColor];
  
  
  if(adView){
    UILabel *nameLabel = (UILabel *)[adView viewWithTag:1002];
    
    
    nameLabel.text = str;
    
    UIButton *detailBtn = (UIButton *)[adView viewWithTag:2001];
    [detailBtn addTarget:self action:@selector(versionUpdateAction) forControlEvents:UIControlEventTouchUpInside];
    
  }
  bgView.alpha = 0.f;
  adView.alpha = 0.f;
  
  [UIView animateWithDuration:.5 animations:^{
    bgView.alpha = 0.5f;
    adView.alpha = 0.9f;
  } completion:^(BOOL finished) {
    bgView.alpha = 0.6f;
    adView.alpha = 1.f;
  }];
}
//关闭版本更新
- (void)closeVersionUpdateAction
{
  UIWindow *curWindow = [UIApplication sharedApplication].keyWindow;
  UIView *bgView = [curWindow viewWithTag:20001];
  bgView.alpha = 0.5f;
  [UIView animateWithDuration:.5 animations:^{
    bgView.alpha = 0.1f;
    ((UIView *)[curWindow viewWithTag:20002]).alpha = 0.1f;
  } completion:^(BOOL finished) {
    [[curWindow viewWithTag:20002] removeFromSuperview];
    [bgView removeFromSuperview];
  }];
}
//版本更新
- (void)versionUpdateAction
{
  [self closeVersionUpdateAction];
  NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id1439533636"];
  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
//弹出通知栏
- (void)popNotificationBar:(NSString *)message
{
  UIWindow *curWindow = [UIApplication sharedApplication].keyWindow;
  CGSize aFactSize = [[UIScreen mainScreen] bounds].size;
  
  UIView *bgView = [curWindow viewWithTag:20001];
  if(!bgView){
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, aFactSize.width, aFactSize.height)];
    bgView.backgroundColor = [UIColor clearColor];
    bgView.tag = 20001;
    [curWindow addSubview:bgView];
  }
  
  UIView *adView = [curWindow viewWithTag:20002];
  if(!adView){
    
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"NotificationBar" owner:self options:nil];
    adView = [nib objectAtIndex:0];
    adView.tag = 20002;
    adView.backgroundColor = [UIColor redColor];
    [adView setFrame:CGRectMake(0, -100, aFactSize.width, 100)];
    [curWindow addSubview:adView];
    
  }
  if(IsNOTNullOrEmptyOfNSString(message)){
    UILabel *aLabel = [adView viewWithTag:1000];
    aLabel.text = message;
  }
  UITapGestureRecognizer *aTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(notificationBarAction)];
  
  [aTapGestureRecognizer setNumberOfTapsRequired:1];
  [adView addGestureRecognizer:aTapGestureRecognizer];
  
  
  [UIView animateWithDuration:.3 animations:^{
    [adView setFrame:CGRectMake(0, 0, aFactSize.width, 100)];
  } completion:^(BOOL finished) {
    [self performSelector:@selector(disMissNotificationBar) withObject:nil afterDelay:3.f];
  }];
}
//无视通知栏
- (void)disMissNotificationBar
{
  UIWindow *curWindow = [UIApplication sharedApplication].keyWindow;
  CGSize aFactSize = [[UIScreen mainScreen] bounds].size;
  
  UIView *bgView = [curWindow viewWithTag:20001];
  
  [UIView animateWithDuration:.5 animations:^{
    [[curWindow viewWithTag:20002] setFrame:CGRectMake(0, -100, aFactSize.width, [curWindow viewWithTag:20002].frame.size.height)];
  } completion:^(BOOL finished) {
    [[curWindow viewWithTag:20002] removeFromSuperview];
    [bgView removeFromSuperview];
  }];
}
//通知栏动作
- (void)notificationBarAction
{
  [self disMissNotificationBar];
  [self pushNotificationVC:_notifyDic];
}
//通知栏VC
- (void)pushNotificationVC:(NSDictionary *)dict
{
  NSString *type=[dict valueForKey:@"act_type"];
  switch ([type intValue]) {
    case 1:
   {
    if(IsNOTNullOrEmptyOfNSString([dict valueForKey:@"goto_url"])){
    }
   }
      break;
    case 2:
   {
    if(IsNOTNullOrEmptyOfNSString([dict valueForKey:@"period_id"])){
    }
   }
      break;
    case 3:
   {
    
   }
      break;
    case 4:
   {
    
   }
      break;
    case 5:
   {
   }
      break;
    case 6:
   {
   }
      break;
    default:
      break;
  }
}
//用户通知
-(void)userInfoNotification:(NSNotification*)notification{
  NSDictionary *dict = [notification userInfo];
  
  if([[dict objectForKey:@"UNPushNotificationTrigger"] intValue]==1){
    _notifyDic = dict;
    NSString *message = @"";
    if(IsNOTNullOrEmptyOfDictionary([[dict objectForKey:@"aps"] objectForKey:@"alert"])){
      message = [[[dict objectForKey:@"aps"] objectForKey:@"alert"] objectForKey:@"body"];//aps通知内容标识符
    }else{
      message = [[dict objectForKey:@"aps"] objectForKey:@"alert"];
    }
    [self popNotificationBar:message];
    
  }else{
    [self pushNotificationVC:dict];
  }
}

#pragma mark - hud缓冲提示
- (void)startLoading:(NSString *)str
{
  if(str == nil || [str isEqualToString:@""])
   {
    str = @"加载中...";//开始
   }
  MBProgressHUD *hud = [MBProgressHUD HUDForView:self.view];
  if(hud == nil)
   {
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
   }
  hud.color = [UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1];

  hud.mode = MBProgressHUDModeCustomView;
  hud.labelText = str;
  hud.labelColor = [UIColor colorWithRed:47/255.0f green:79/255.0f blue:79/245.0f alpha:1];
  hud.labelFont = [UIFont boldSystemFontOfSize:15.f];
}
//暂停加载
- (void)stopLoading
{
  if ([NSThread isMainThread]) {
   // [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
  } else {
    dispatch_sync(dispatch_get_main_queue(), ^{
   //   [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
    });
  }
}

- (void)sortBtnClicked:(id)sender;
{
  NSLog(@"排序按钮事件");
}

#pragma mark AutoAlert -自动提示警示框
- (void) dimissAlert:(UIAlertController *)alert {
  if(alert){
    [alert dismissViewControllerAnimated:YES completion:^{
      [self alertActionDone:alert];
    }];
  }
}
//显示后自动消失警报
- (void)showAutoDisappearAlert:(NSString *)message{
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
  [self presentViewController:alert animated:YES completion:^{
    [self performSelector:@selector(dimissAlert:) withObject:alert afterDelay:2.f];
  }];
}
//警报完成
- (void)alertActionDone:(UIAlertController *)alertView{
  
}
//通用照片缩略图
- (UIImage *)generatePhotoThumbnail:(UIImage *)image
{
  CGSize asize = CGSizeMake(64, 64);
  UIImage *newimage;
  
  if (nil == image) {
    
    newimage = nil;
    
  }
  
  else{
    
    CGSize oldsize = image.size;
    
    CGRect rect;
    
    if (asize.width/asize.height > oldsize.width/oldsize.height) {
      
      rect.size.width = asize.height*oldsize.width/oldsize.height;
      
      rect.size.height = asize.height;
      
      rect.origin.x = (asize.width - rect.size.width)/2;
      
      rect.origin.y = 0;
      
    }
    
    else{
      
      rect.size.width = asize.width;
      
      rect.size.height = asize.width*oldsize.height/oldsize.width;
      
      rect.origin.x = 0;
      
      rect.origin.y = (asize.height - rect.size.height)/2;
      
    }
    
    UIGraphicsBeginImageContext(asize);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    
    UIRectFill(CGRectMake(0, 0, asize.width, asize.height));
    
    [image drawInRect:rect];
    
    newimage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
  }
  
  return newimage;
}

//获取当前设备模型
- (NSString *)getCurrentDeviceModel
{
  int mib[2];
  size_t len;
  char *machine;
  
  mib[0] = CTL_HW;
  mib[1] = HW_MACHINE;
  sysctl(mib, 2, NULL, &len, NULL, 0);
  machine = malloc(len);
  sysctl(mib, 2, machine, &len, NULL, 0);
  
  NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
  free(machine);
  
  if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
  if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
  if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
  if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
  if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
  if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
  if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387/A1431)";
  if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
  if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
  if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
  if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
  if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
  if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
  if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
  if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
  
  if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
  if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
  if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
  if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
  if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
  
  if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
  
  if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
  if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
  if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
  if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
  if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
  if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
  if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
  
  if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
  if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
  if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
  if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
  if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
  if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
  
  if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
  if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
  if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
  if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
  if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
  if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
  
  if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
  if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
  return platform;
  NSLog(@"手机设备型号：%@",platform);
}

#pragma mark camera utility -相机实用程序
//是否打开相机权限
- (BOOL) isCameraAvailable{
  return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}
//后置摄像头
- (BOOL) isRearCameraAvailable{
  return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}
//前置摄像头
- (BOOL) isFrontCameraAvailable {
  return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}
//拍摄照片权限
- (BOOL) doesCameraSupportTakingPhotos {
  return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}
//照片库是否可用
- (BOOL) isPhotoLibraryAvailable{
  return [UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypePhotoLibrary];
}
//用户可以从照片库中选择视频吗？
- (BOOL) canUserPickVideosFromPhotoLibrary{
  return [self
          cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
//用户可以从照片库中选择图片吗？
- (BOOL) canUserPickPhotosFromPhotoLibrary{
  return [self
          cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
//摄影媒体类型
- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
  __block BOOL result = NO;
  if ([paramMediaType length] == 0) {
    return NO;
  }
  NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
  [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
    NSString *mediaType = (NSString *)obj;
    if ([mediaType isEqualToString:paramMediaType]){
      result = YES;
      *stop= YES;
    }
  }];
  return result;
}

//旋转图片
- (UIImage*)rotateImage:(UIImage *)image
{
  int kMaxResolution = 960; // 或者另一个角度
  CGImageRef imgRef = image.CGImage;
  
  CGFloat width = CGImageGetWidth(imgRef);
  CGFloat height = CGImageGetHeight(imgRef);
  
  CGAffineTransform transform = CGAffineTransformIdentity;
  CGRect bounds = CGRectMake(0, 0, width, height);
  if (width > kMaxResolution || height > kMaxResolution) {
    CGFloat ratio = width/height;
    if (ratio > 1) {
      bounds.size.width = kMaxResolution;
      bounds.size.height = bounds.size.width / ratio;
    }
    else {
      bounds.size.height = kMaxResolution;
      bounds.size.width = bounds.size.height * ratio;
    }
  }
  
  CGFloat scaleRatio = bounds.size.width / width;
  CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
  CGFloat boundHeight;
  UIImageOrientation orient = image.imageOrientation;
  switch(orient) {
      
    case UIImageOrientationUp: //EXIF = 1
      transform = CGAffineTransformIdentity;
      break;
      
    case UIImageOrientationUpMirrored: //EXIF = 2
      transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
      transform = CGAffineTransformScale(transform, -1.0, 1.0);
      break;
      
    case UIImageOrientationDown: //EXIF = 3
      transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
      transform = CGAffineTransformRotate(transform, M_PI);
      break;
      
    case UIImageOrientationDownMirrored: //EXIF = 4
      transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
      transform = CGAffineTransformScale(transform, 1.0, -1.0);
      break;
      
    case UIImageOrientationLeftMirrored: //EXIF = 5
      boundHeight = bounds.size.height;
      bounds.size.height = bounds.size.width;
      bounds.size.width = boundHeight;
      transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
      transform = CGAffineTransformScale(transform, -1.0, 1.0);
      transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
      break;
      
    case UIImageOrientationLeft: //EXIF = 6
      boundHeight = bounds.size.height;
      bounds.size.height = bounds.size.width;
      bounds.size.width = boundHeight;
      transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
      transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
      break;
      
    case UIImageOrientationRightMirrored: //EXIF = 7
      boundHeight = bounds.size.height;
      bounds.size.height = bounds.size.width;
      bounds.size.width = boundHeight;
      transform = CGAffineTransformMakeScale(-1.0, 1.0);
      transform = CGAffineTransformRotate(transform, M_PI / 2.0);
      break;
      
    case UIImageOrientationRight: //EXIF = 8
      boundHeight = bounds.size.height;
      bounds.size.height = bounds.size.width;
      bounds.size.width = boundHeight;
      transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
      transform = CGAffineTransformRotate(transform, M_PI / 2.0);
      break;
      
    default:
      [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
      
  }
  
  UIGraphicsBeginImageContext(bounds.size);
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
    CGContextScaleCTM(context, -scaleRatio, scaleRatio);
    CGContextTranslateCTM(context, -height, 0);
  }
  else {
    CGContextScaleCTM(context, scaleRatio, -scaleRatio);
    CGContextTranslateCTM(context, 0, -height);
  }
  
  CGContextConcatCTM(context, transform);
  
  CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
  //基于当前图像上下文的图形用户界面图形
  UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return imageCopy;
}
//清晰度
- (BOOL)isPureInt:(NSString*)string{
  NSScanner* scan = [NSScanner scannerWithString:string];
  int val;
  return[scan scanInt:&val] && [scan isAtEnd];
}
//图片颜色
- (UIImage *)imageWithColor:(UIColor *)color
{
  CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
  UIGraphicsBeginImageContext(rect.size);
  //UI图形获取当前上下文
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  CGContextSetFillColorWithColor(context, [color CGColor]);
  CGContextFillRect(context, rect);
  //基于当前图像上下文的图形用户界面图形
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return image;
}

- (void)showError:(NSError *)error
{
  //调用接口是断网状态下  需要进行断网提示。
  [self stopLoading];
  if(error.code != API_Update_ErrorCode){
    [self hideEmpthView];
    if(IsNOTNullOrEmptyOfNSString([[error userInfo] objectForKey:NSLocalizedDescriptionKey])){
      CSAlert([[error userInfo] objectForKey:NSLocalizedDescriptionKey]);
    }else{
      CSAlert(@"接口异常");
    }
  }else{
    [self showEmptyView:[[error userInfo] objectForKey:NSLocalizedDescriptionKey] WithImage:[UIImage imageNamed:@"Common_noOrder"] WithPosition:CGPointZero createBtn:NO];
    [self.view bringSubviewToFront:[self.view viewWithTag:10]];
  }
}

@end

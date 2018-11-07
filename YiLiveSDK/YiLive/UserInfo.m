//
//  UserInfo.m
//  YiLive
//
//  Created by Zhenglj on 2018/10/18.
//  Copyright © 2018年 郑吕杰. All rights reserved.
//

#import "UserInfo.h"
#import "Comfirm.h"
#import "MePage.h"

#import "DatePickerView.h"
#import "ChooseSexView.h"
#import "ScrollChooseView.h"
#import "CityPickView.h"


@interface UserInfo ()<UIActionSheetDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,strong) UITextField * textField;
@property (nonatomic,strong)UITextField *text;
@property ( nonatomic,strong) UIImageView *bg;


@property (nonatomic,strong) NSString *nickName;//昵称
@property (nonatomic,strong) NSString *sex;//性别
@property (nonatomic,strong) NSString *borth;//生日
@property (nonatomic,strong) NSString *province;//省份


@end

@implementation UserInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setPhoto];
  
  self.title = @"注册个人信息";
  self.view.backgroundColor = [UIColor whiteColor];
  self.navigationController.navigationBarHidden = YES;
  
  
  NSString *nickname = [NSString stringWithFormat:@"%@",_nickName];
  NSArray *fieldArray = @[@""];
  for (int r = 0; r<1; r++) {
    _text = [[UITextField alloc]init];
    _text.placeholder = @"昵称";
    [_text setText:fieldArray[r]];
    _text.textAlignment = NSTextAlignmentCenter;
    _text.frame = CGRectMake(20, 270+r*35+r*25, KScreen_Width-40, 50);
    [_text setTextColor:[UIColor colorWithRed:30/255.0f green:144/255.0f blue:255/255.0f alpha:1]];
    _text.backgroundColor = [UIColor colorWithRed:253/255.0f green:216/255.0f blue:254/255.0f alpha:1];
    _text.tag = r;
    [self.view addSubview:_text];
  }
  NSLog(@"昵称 = %@",_nickName);
  UIButton *goToComfirmButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  goToComfirmButton.frame = CGRectMake(20, 650, KScreen_Width-40,50);
  goToComfirmButton.backgroundColor = [UIColor colorWithRed:248/255.0f green:216/255.0f blue:254/255.0f alpha:1];
  [goToComfirmButton setTitle:@"完成" forState:UIControlStateNormal];
  goToComfirmButton.titleLabel.font = [UIFont systemFontOfSize:17.0f];
  goToComfirmButton.layer.cornerRadius=5.0f;
  [goToComfirmButton addTarget:self action:@selector(goToComfirmButton) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:goToComfirmButton];
  
  
  //选择器=======================
  NSArray *titleArray = @[@"性  别",@"生  日",@"省  份"];
  
  for (int i = 0; i<3; i++) {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(20, 350+i*45+i*35, KScreen_Width-40, 50);
    [btn setTitle:titleArray[i] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor colorWithRed:253/255.0f green:216/255.0f blue:254/255.0f alpha:1];
    [btn addTarget:self action:@selector(chooseValue:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    btn.tag = i;
    [self.view addSubview:btn];
  }
}




- (void)chooseValue:(UIButton *)btn{
  
  NSLog(@"tag = %ld",(long)btn.tag);
  switch (btn.tag) {
      //普通样式的性别选择器
    case 0:
   {
    ChooseSexView *sheetView = [[ChooseSexView alloc]initWithTitle:@"性别修改" buttons:@[@"男",@"女",@"取消"] buttonClick:^(ChooseSexView *chooseSexView, NSInteger buttonIndex) {
      
      if (buttonIndex == 0){
        [btn setTitle:@"男" forState:UIControlStateNormal];
          _sex = @"男";
      }else if (buttonIndex == 1){
        [btn setTitle:@"女" forState:UIControlStateNormal];
        _sex = @"女";
      }
      NSLog(@"性别：%@",_sex);
    }];
    [sheetView showView];
    
   }
      break;
    case 1:
      //  滚样式日期选择器
   {
    //年-月-日
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *selectDate) {
      
      NSString *dateString = [selectDate stringWithFormat:@"yyyy-MM-dd"];
      NSLog(@"选择的日期：%@",dateString);
        _borth = dateString;
      [btn setTitle:dateString forState:UIControlStateNormal];
    }];
    datepicker.dateLabelColor = [UIColor blackColor];//年-月-日 颜色
    datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
    datepicker.doneButtonColor = [UIColor colorWithRed:248/255.0f green:216/255.0f blue:254/255.0f alpha:1];//确定按钮的颜色
    [datepicker show];
   
  }
      break;
    case 2:
      //滚样式城市选择器
   {
    [CityPickView showPickViewWithComplete:^(NSArray *arr) {
      
      NSString *str =  [self replaceUnicode:[NSString stringWithFormat:@"%@%@%@",arr[0],arr[1],arr[2]]];
      [btn setTitle:str forState:UIControlStateNormal];
        
        _province = str;
      
    } withProvince:@"广东省" withCity:@"广州市" withTown:nil withThreeScroll:YES];
     NSLog(@"选择的城市：%@",_province);
   }
      
      break;
    default:
      break;
  }
  
}
/**     转码为中文
 @param  TransformUnicodeString 转码前
 @return 转码后
 */
-(NSString*) replaceUnicode:(NSString*)TransformUnicodeString

{
  NSString*tepStr1 = [TransformUnicodeString stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
  NSString*tepStr2 = [tepStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
  NSString*tepStr3 = [[@"\""  stringByAppendingString:tepStr2]stringByAppendingString:@"\""];
  NSData*tepData = [tepStr3  dataUsingEncoding:NSUTF8StringEncoding];
  NSString*axiba = [NSPropertyListSerialization propertyListWithData:tepData options:NSPropertyListMutableContainers format:NULL error:NULL];
  return  [axiba stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}

-(void)setPhoto{
  _bg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250)];
  [_bg setImage:[UIImage imageNamed:@"粉色头像"]];
  _bg.backgroundColor=[UIColor grayColor];
  [self.view addSubview:_bg];
  
  _head=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-80)/2, 110, 80, 80)];
  [_head setImage:[UIImage imageNamed:@"粉色头像"] forState:UIControlStateNormal];
  _head.layer.cornerRadius=40;
  _head.layer.masksToBounds = YES;
  _head.backgroundColor=[UIColor colorWithRed:248/255.0f green:216/255.0f blue:254/255.0f alpha:1];
  [_head addTarget:self action:@selector(changeHeadView:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:_head];
  
  UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width-80)/2, 180, 80, 80)];
  label.text=@"点击设置头像";
  label.textColor=[UIColor whiteColor];
  label.font=[UIFont systemFontOfSize:13];
  [self.view addSubview:label];
  
}
//传值
-(void)goToComfirmButton{
  Comfirm *nav = [[Comfirm alloc]init];
    nav.image = _bg.image;
    nav.nickName = _text.text;
    nav.sex = _sex;
    nav.borth = _borth;
    nav.province = _province;
  [self.navigationController pushViewController:nav animated:YES];
  NSLog(@"个人信息：%@, %@, %@, %@",nav.nickName, nav.sex, nav.borth, nav.province);
}
//改变头像
-(void)changeHeadView:(UIButton *)tap{
  UIActionSheet *changePhoto = [[UIActionSheet alloc] initWithTitle:@"更改图像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册上传", nil];
  changePhoto.delegate=self;
  changePhoto.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
  [changePhoto showInView:self.view];
}

//代理方法
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
  //0->拍照，1->相册
  
  if (buttonIndex == 0) {
    [self snapImage];
  } else if (buttonIndex == 1) {
    [self localPhoto];
  }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
  //完成选择
  NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
  //NSLog(@"type:%@",type);
  if ([type isEqualToString:@"public.image"]) {
    //转换成NSData
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    //关闭相册界面
    [picker dismissViewControllerAnimated:YES completion:^{
      //设置头像
      [_head setImage:image forState:UIControlStateNormal];
      //上传头像
      //[self updatePhotoFor:image];
    }];
    
  }
}


#pragma mark --头像上传
-(void)updatePhoto:(NSString *)base64Str
{
  
}

//拍照
- (void) snapImage
{
  if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    __block UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    ipc.allowsEditing = YES;
    ipc.navigationBar.barTintColor =[UIColor whiteColor];
    ipc.navigationBar.tintColor = [UIColor whiteColor];
    ipc.navigationBar.titleTextAttributes = @{UITextAttributeTextColor:[UIColor whiteColor]};
    [self presentViewController:ipc animated:YES completion:^{
      ipc = nil;
    }];
  } else {
    NSLog(@"模拟器无法打开照相机");
  }
}

#define CommonThimeColor HEXCOLOR(0x11a0ee)
-(void)localPhoto
{
  __block UIImagePickerController *picker = [[UIImagePickerController alloc] init];
  
  picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
  picker.delegate = self;
  //设置选择后的图片可被编辑
  picker.allowsEditing = YES;
  picker.navigationBar.barTintColor =[UIColor whiteColor];
  picker.navigationBar.tintColor = [UIColor blackColor];
  picker.navigationBar.titleTextAttributes = @{UITextAttributeTextColor:[UIColor blackColor]};
  [self presentViewController:picker animated:YES completion:^{
    picker = nil;
  }];
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  [picker dismissViewControllerAnimated:YES completion:^{
    
  }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}



@end

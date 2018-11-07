//
//  Macro.h
//  YiLive
//
//  Created by Zhenglj on 2018/10/18.
//  Copyright © 2018年 郑吕杰. All rights reserved.
//

/** all comment Macro define in here ***/

#ifndef Macro_h
#define Macro_h



#define Theme_Color_Pink RGB(255,83,123)//Bar字体颜色
#define Nav_Back_Font_M [UIFont systemFontOfSize:14]//导航栏字体
#define KNavigationBar_HEIGHT 44//导航栏标准高度

#define kScreenSize [UIScreen mainScreen].bounds.size//屏幕尺寸
#define KScreen_Width ([UIScreen mainScreen].bounds.size.width)//获取屏幕宽度
#define KScreen_Height ([UIScreen mainScreen].bounds.size.height)//获取屏幕高度
//设备屏幕大小
#define HTScreenWidth [[UIScreen mainScreen]bounds].size.width
#define HTScreenHeight [[UIScreen mainScreen]bounds].size.height
//iphone各型号屏幕尺寸
#define Is320Width ((int)[UIScreen mainScreen].bounds.size.width == 320?YES:NO)
#define Is475Width ((int)[UIScreen mainScreen].bounds.size.width == 375?YES:NO)
#define Is414Width ((int)[UIScreen mainScreen].bounds.size.width == 414?YES:NO)

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

//弹出通知栏信息
#define IsNOTNullOrEmptyOfNSString(_STRING___) (_STRING___ && [_STRING___ isKindOfClass:[NSString class]] && [_STRING___ length])

#define IsNOTNullOrEmptyOfDictionary(_DICTIONARY___) (_DICTIONARY___ && [_DICTIONARY___ isKindOfClass:[NSDictionary class]] && [_DICTIONARY___ count])

//适配iphoneX
#define Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define iPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IOS6 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6?YES:NO)
#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7?YES:NO)
#define IS_IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8?YES:NO)
#define IS_IOS9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9?YES:NO)
#define IS_IOS10 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10?YES:NO)
#define IS_IOS11 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11?YES:NO)

//获取图片资源名称
#define KGetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:"图片名称:%@",imageName];
//获取当前语言
#define KCurrentLanguage ([[NSLocalepreferredLanguages] objectAtIndex:0])
//判断iOS大于8.0的系统版本
#define IOS8 (([[[UIDevice currentDevice] systemVersion] floatValue] > 8.0)? (YES):(NO))

//弹出视图Alert
#define CSAlert(_S_) \
UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:_S_ preferredStyle:UIAlertControllerStyleAlert];[alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil]];[self presentViewController:alert animated:YES completion:nil];

//断网接口提示
#define API_Update_ErrorCode               -92007

// 日志输出
#ifdef DEBUG //测试 处于开发阶段

// 真机打印测试
#define ZLString [NSString stringWithFormat:@"%s", __FILE__].lastPathComponent
#define ZLLog(...) printf("%s 第%d行: %s\n\n", [ZLString UTF8String] ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String]);

#else //发布 处于发布阶段
#define ZLLog(...)
#endif


//崩溃日志
#ifdef DEBUG
#define XHPayKitLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define XHPayKitLog(...)
#endif



//主色调 金黄色
#define ColorMainBase [UIColor colorWithHexString:@"#E66391"]
//主背景色调 亚麻色
#define  ColorMainBackGround [UIColor colorWithHexString:@"#FAF0E6"]
//当前版本
#define BundleVersion [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"]
//获取当前版本号
#define CurrentVersion [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"]
//默认图
#define CoverPlaceholderImage [UIImage imageNamed:@"coverPlaceHolder.jpg"]
#define IconPlaceholderImage [UIImage imageNamed:@"icon_placeholder"]
//断网接口提示
#define KNetError KNSLocalizedString(@"网络错误") -92007
// NSlocalizeString 第一个参数是内容,根据第一个参数去对应语言的文件中取对应的字符串，第二个参数将会转化为字符串文件里的注释，可以传nil，也可以传空字符串@""。
#define KNSLocalizedString(key) NSLocalizedString(key, nil)

//-----------------------弱引用--------------------------
#define WEAKSELF typeof(self) __weak weakSelf = self;//自己
#define STRONGSELF typeof(self) __strong strongSelf = self;//字符串
#define STRONGSELFFor(object) typeof(object) __strong strongSelf = object;//对象

//----------------------------- view 圆角和边框---------------------------
#define KViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

//----------------------------- View 圆角-------------------------------
#define KViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

// ------------------------------ View加边框-----------------------------
#define KViewBorder(View, BorderColor, BorderWidth )\
\
View.layer.borderColor = BorderColor.CGColor;\
View.layer.borderWidth = BorderWidth;

//8.字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )

//9.数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)

//10.字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)

//11.是否是空对象
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

#pragma mark - 💗💗💗【 常用的缩写 】
//////////////////////////////////////////////////////////////////////////////
/**
 *  💗【 常用的缩写 】
 **/
//////////////////////////////////////////////////////////////////////////////
#define kApplication        [UIApplication sharedApplication]
#define kKeyWindow          [UIApplication sharedApplication].keyWindow
#define kAppDelegate        [UIApplication sharedApplication].delegate
#define kUserDefaults      [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]



#endif /* Macro_h */

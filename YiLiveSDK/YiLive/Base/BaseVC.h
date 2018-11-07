//
//  BaseVC.h
//  YiLive
//
//  Created by Zhenglj on 2018/10/22.
//  Copyright © 2018年 郑吕杰. All rights reserved.
//

#import "ViewController.h"

@interface BaseVC : UIViewController
{
  MBProgressHUD *HUD; //警告视图
  BOOL isShownEmpty;//空视图
  BOOL isAddConnectView;//添加链接视图
  BOOL isCheckConnection;//检验视图
  NSDictionary *_notifyDic;//通知Dic
}

-(void)showEmptyView:(NSString *)str
           WithImage:(UIImage *)img
           WithPosition:(CGPoint)pos
           createBtn:(BOOL)yesNO;
-(void)hideEmpthView;//隐藏空视图
-(void)startLoading:(NSString *)str;//开始加载
-(void)stopLoading;//停止

-(void)checkConncetion;//校验链接
-(void)reloadButtonAction:(UIButton *)sender;//重新加载

-(void)showAutoDisappearAlert:(NSString *)message;//警告信息显示后自动消失
-(void)alertActionDone:(UIAlertController *)alertView;//警告完成

-(UIImage *)generatePhotoThumbnail:(UIImage *)image;//通用照片缩略图
-(NSString *)getCurrentDeviceModel;//获取当前设备模型

-(BOOL) isCameraAvailable;//是否打开相机
-(BOOL) isRearCameraAvailable;//后置摄像头
-(BOOL) isFrontCameraAvailable;//前置摄像头
-(BOOL) doesCameraSupportTakingPhotos;//相机是否支持拍照
-(BOOL) isPhotoLibraryAvailable;//照片库可用吗
-(BOOL) canUserPickVideosFromPhotoLibrary;//用户可以从照片库中选择视频吗？
-(BOOL) canUserPickPhotosFormPhotoLibrary;//用户可以从照片库中选择图片吗？
-(BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType;//摄影媒体类型
-(UIImage *)rotateImage:(UIImage *)image;//旋转图片
-(void)showError:(NSError *)error;//报错
-(BOOL)isPureInt:(NSString *)string;//清晰度
@end

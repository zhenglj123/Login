//
//  THChooseSexView.h
//  Login
//
//  Created by zhenglj on 2018/9/06.
//  Copyright © 2018年 zlj. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface ChooseSexView : UIView


@property (nonatomic, copy) void(^buttonClick)(ChooseSexView *chooseSexView,NSInteger buttonIndex);


/**
 Description

 @param title 弹出框标题
 @param buttons 按钮列表
 @param block 选择项
 @return self
 */
- (id)initWithTitle:(NSString *)title buttons:(NSArray <NSString *>*)buttons buttonClick:(void(^)(ChooseSexView *chooseSexView,NSInteger buttonIndex))block;


/**
 显示弹出框
 */
- (void)showView;

@end

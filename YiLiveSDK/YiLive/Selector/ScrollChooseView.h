//
//  THScrollChooseView.h
//  Login
//
//  Created by zhenglj on 2018/9/06.
//  Copyright © 2018年 zlj. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef void(^ScrollChooseViewBlock)(NSInteger selectedValue);

@interface ScrollChooseView : UIView

@property (strong, nonatomic) ScrollChooseViewBlock confirmBlock;
/**
 布局
 @param questionArray 问题数组
 @return self
 */
- (instancetype)initWithQuestionArray:(NSArray *)questionArray withDefaultDesc:(NSString *)defaultDesc;
- (void)showView;







@end

//
//  JScallOC.m
//  YiLive
//
//  Created by Zhenglj on 2018/10/11.
//  Copyright © 2018年 郑吕杰. All rights reserved.
//

#import "JScallOC.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
@interface JScallOC ()<UIWebViewDelegate>
@property (nonatomic, weak) UIWebView *webView;
@end

@implementation JScallOC

#pragma mark - 加载网页

- (void)viewDidLoad {
  
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
  UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(bkClick)];
  [addBtn setImage:[UIImage imageNamed:@"导航栏图标"]];
  [addBtn setImageInsets:UIEdgeInsetsMake(0, 20, 25, 25)];
  addBtn.tintColor=[UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1];
  [self.navigationItem setLeftBarButtonItem:addBtn];
  
  NSString *path = [[[NSBundle mainBundle]bundlePath]stringByAppendingPathComponent:@"JS.html"];
  NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
  UIWebView  * webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 40, 412, 735)];
  webView.delegate = self;
  [webView loadRequest:request];
  [self.view addSubview:webView];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
  
  JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
  
  context[@"onClickOC"] = ^() {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"打开支付宝？" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
          [self.navigationController popViewControllerAnimated:YES]; //这里写选择确定之后的操作
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
          NSLog(@"用户继续操作");
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    
  };
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
  JSContext *context = [UIWebView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
  NSString *alertJS = @"showAlert('test OC js')";
  [context evaluateScript:alertJS];
}

-(void)bkClick
{
  [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}


@end

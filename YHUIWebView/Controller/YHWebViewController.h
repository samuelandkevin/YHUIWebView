//
//  YHWebViewController.h
//  PikeWay
//
//  Created by YHIOS002 on 16/6/24.
//  Copyright © 2016年 YHSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "YHLoadView.h"


@interface YHWebViewController : UIViewController
@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,assign) BOOL showBtnScorllToTop;
@property (nonatomic,assign) BOOL enableIQKeyBoard;
@property (nonatomic,assign) BOOL presentedVC;
@property (nonatomic,assign) BOOL manualLoadReq;
@property (nonatomic,strong) NSURL *url;

- (instancetype)initWithFrame:(CGRect)frame url:(NSURL *)url;


//Mark:提供父类的方法,子类可以根据需求重定义
- (void)setUpNavigationBar;
- (void)webViewDidFinishLoad:(UIWebView *)webView;
@end

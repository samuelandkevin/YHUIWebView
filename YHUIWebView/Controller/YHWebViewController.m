//
//  YHWebViewController.m
//  PikeWay
//
//  Created by YHIOS002 on 16/6/24.
//  Copyright © 2016年 YHSoft. All rights reserved.
//

#import "YHWebViewController.h"

@interface YHWebViewController ()<UIWebViewDelegate>

@property (nonatomic,assign) CGRect rect;
@property (nonatomic,strong) UIButton *btnScrollToTop;
@property (nonatomic,strong) YHLoadView *viewLoadFail;
@property (nonatomic,strong) YHLoadView *viewLoading;
@end

@implementation YHWebViewController

- (instancetype)initWithFrame:(CGRect)frame url:(NSURL *)url{
    if (self  = [super init]) {
        _url  = url;
        _rect = frame;
    }
    return self;
}

- (instancetype)initWithURL:(NSURL *)url{
    if(self = [super init]){
        _url = url;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
   
}

- (void)setUpNavigationBar{
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelBtn.frame = CGRectMake(0, 0, 40, 40);
    //    [cancelBtn setTitle:@"返回" forState:UIControlStateNormal];
    [cancelBtn setImage:[UIImage imageNamed:@"leftarrow"] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    cancelBtn.titleLabel.textColor = [UIColor whiteColor];
    [cancelBtn addTarget:self action:@selector(onBack:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn];
    
    self.navigationController.navigationBar.translucent = NO;
}

- (void)initUI{
    
    [self setUpNavigationBar];
    
    //1.webview
    _webView = [[UIWebView alloc] initWithFrame:_rect];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    _webView.opaque = NO;
    NSMutableURLRequest *mreq = [NSMutableURLRequest requestWithURL:_url];
    if (!_manualLoadReq) {
        [_webView loadRequest:mreq];
    }
    [_webView setScalesPageToFit:YES];
    
    
    //2.btnScorllToTop
    _btnScrollToTop = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-50, SCREEN_HEIGHT-210, 40, 40)];
    _btnScrollToTop.layer.cornerRadius  = 20;
    _btnScrollToTop.layer.masksToBounds = YES;
    [_btnScrollToTop setTitle:@"|" forState:UIControlStateNormal];
    _btnScrollToTop.hidden = self.showBtnScorllToTop?NO:YES;
    _btnScrollToTop.backgroundColor = [kGreenColor colorWithAlphaComponent:0.8];
    [_btnScrollToTop addTarget:self action:@selector(onScrollToTop:) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:_btnScrollToTop aboveSubview:_webView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.webView.backgroundColor = [UIColor colorWithWhite:0.957 alpha:1.000];
    
//    WeakSelf
//    [YHLoadView onReloadBtnInSuperView:weakSelf.view handler:^{
//        DDLog(@"onReload");
//        NSMutableURLRequest *mreq = [NSMutableURLRequest requestWithURL:weakSelf.url];
//        [weakSelf.webView loadRequest:mreq];
//    }];
}

#pragma mark - Lazy Load
- (YHLoadView *)viewLoading{
    if (!_viewLoading) {
        _viewLoading = [YHLoadView loading];
        _viewLoading.center = CGPointMake(self.view.centerX, SCREEN_HEIGHT/4);
        [self.view addSubview:_viewLoading];
    }
    return _viewLoading;
}

- (YHLoadView *)viewLoadFail{
    if(!_viewLoadFail){
        _viewLoadFail = [YHLoadView loadFail];
        _viewLoadFail.center = CGPointMake(self.view.centerX, SCREEN_HEIGHT/4);
        WeakSelf
        [_viewLoadFail onReloadHandler:^{
            
            NSMutableURLRequest *mreq = [NSMutableURLRequest requestWithURL:weakSelf.url];
            [weakSelf.webView loadRequest:mreq];
        }];
        [self.view addSubview:_viewLoadFail];
    }
    return _viewLoadFail;
}



#pragma mark - Action
- (void)onBack:(id)sender{
    if ([_webView canGoBack]) {
        [_webView goBack];
    }
    else{
        if(_presentedVC){
            [self dismissViewControllerAnimated:YES completion:NULL];
        }else
            [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)onScrollToTop:(id)sender{
    if ([_webView subviews]) {
        UIScrollView * scrollView = [[_webView subviews] objectAtIndex:0];
        [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}


#pragma mark - Life
- (void)viewWillAppear:(BOOL)animated{
  
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
}

- (void)dealloc{
    self.webView.delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Public


#pragma mark - UIWebViewDelegate

//网页开始加载的时候调用
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidStartLoad");
    
    [self.viewLoading showLoadingView];
    [self.viewLoadFail hideFailView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.viewLoading hideLoadingView];
    [self.viewLoadFail hideFailView];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [self.viewLoading hideLoadingView];
    
    if ([error.userInfo[@"cache"] boolValue] == NO) {
        NSLog(@"no HTML cache");
        [self.viewLoadFail showLoadFailView];
    }
   
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

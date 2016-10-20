//
//  ViewController.m
//  YHUIWebView
//
//  Created by YHIOS002 on 16/10/20.
//  Copyright © 2016年 YHSoft. All rights reserved.
//

#import "ViewController.h"
#import "YHWebViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (IBAction)onBtn:(id)sender {
    
    YHWebViewController *vc = [[YHWebViewController alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) url:[NSURL URLWithString:@"https://testapp.gtax.cn/taxtao/index?accessToken=14DE6F102F0246188203AA300A77421C"]];
    [self.navigationController pushViewController:vc  animated:YES];
}

#pragma mark - Life
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

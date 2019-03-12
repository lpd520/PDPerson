//
//  PDHomeVC.m
//  PDPerson
//
//  Created by mac on 2018/10/7.
//  Copyright © 2018年 QingYe. All rights reserved.
//

#import "PDHomeVC.h"
#import "PDWebViewController.h"
#import "PDMineVC.h"
#import "PDReachability.h"

#import "PDLoadingView.h"
#import "PDButton.h"

@interface PDHomeVC ()

@end

@implementation PDHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    
    [PDReachability checkNetworkStatusOn:^(NSString *status) {
        // [SVProgressHUD showNOmessage:status];
        NSLog(@"---->%@",status);
    }];
    
}

-(void)configure{
    [super configure];
    // title
    self.title = @"Home";
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home"] style:UIBarButtonItemStylePlain target:self action:@selector(clickRightButtonItem)];
}

#pragma mark - life cycle  生命周期

#pragma mark - notification  通知
//在viewDidAppear里面做Notification的监听之类的事情

#pragma mark - action  事件处理

-(void)clickRightButtonItem{
    
    PDWebViewController *mainPageVC = [[PDWebViewController alloc] init];
    mainPageVC.requestURL = @"https://www.baidu.com";
    [self pushToVC:mainPageVC];
    
}

#pragma mark - Delegate

#pragma mark - UI  界面搭建

#pragma mark - other

#pragma mark - setter & getter
//设置view基本坐标、属性等

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end

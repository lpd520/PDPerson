//
//  PDTabBarController.m
//  PDPerson
//
//  Created by mac on 2018/10/7.
//  Copyright © 2018年 QingYe. All rights reserved.
//

#import "PDTabBarController.h"
#import "PDNavigationController.h"
#import "PDTableViewController.h"
#import "PDMineVC.h"
#import "PDHomeVC.h"
#import "PDWebViewController.h"
@interface PDTabBarController ()

@end

@implementation PDTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setTabbarBgColor];
    [self setupChildVCs];
}

#pragma 添加子控制器
-(void)setupChildVCs{
    
    //1.首页
    PDViewController *mainPageVC = [[PDHomeVC alloc] init];
    UINavigationController *nav = [[PDNavigationController alloc] initWithRootViewController:mainPageVC];
    [self addChildViewController:nav];
    [self setTabbarContent:mainPageVC image:[UIImage imageNamed:@"home"] selectImg:[UIImage imageNamed:@"home_s"] title:@"首页"];
    
    
    //4.税收
    PDTableViewController *texVC = [[PDTableViewController alloc] init];
    UINavigationController *nav4 = [[PDNavigationController alloc] initWithRootViewController:texVC];
    [self addChildViewController:nav4];
    [self setTabbarContent:texVC image:[UIImage imageNamed:@"mine"] selectImg:[UIImage imageNamed:@"mine_s"] title:@"税收"];
    
}


#pragma 设置tabbar内容
-(void)setTabbarContent:(PDViewController *)VC image:(UIImage *)image selectImg:(UIImage *)selectImg title:(NSString *)title{
    
    VC.tabBarItem.title = title;//设置title
    
    [VC.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]} forState:UIControlStateNormal];    //设置title的字体
    
    VC.tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//设置图标
    
    VC.tabBarItem.selectedImage =  [selectImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//设置选中图标
    
    NSDictionary *dicNormal = @{NSForegroundColorAttributeName:[UIColor lightGrayColor]};
    NSDictionary *dicSelected = @{NSForegroundColorAttributeName:[UIColor blackColor]};
    [VC.tabBarItem setTitleTextAttributes:dicNormal forState:UIControlStateNormal];
    [VC.tabBarItem setTitleTextAttributes:dicSelected forState:UIControlStateSelected];
    
}

-(void)setTabbarBgColor{
    
    UIView *bgView = [[UIView alloc] initWithFrame:self.tabBar.bounds];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.tabBar insertSubview:bgView atIndex:0];
//    self.tabBar.opaque = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

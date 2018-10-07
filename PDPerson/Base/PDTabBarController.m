//
//  PDTabBarController.m
//  PDPerson
//
//  Created by mac on 2018/10/7.
//  Copyright © 2018年 QingYe. All rights reserved.
//

#import "PDTabBarController.h"
#import "PDNavigationController.h"

@interface PDTabBarController ()

@end

@implementation PDTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

#pragma 添加子控制器
-(void)setupChildVCs{
    
    //1.首页
    PDViewController *mainPageVC = [[PDFirstPageVC alloc] init];
    
    UINavigationController *nav = [[PDNavigationVC alloc] initWithRootViewController:mainPageVC];
    
    [self addChildViewController:nav];
    [self setTabbarContent:mainPageVC image:[UIImage imageNamed:@"首页"] selectImg:[UIImage imageNamed:@"首页-选中"] title:@"首页"];
    
    //2.服务
    PDViewController *serviceVC = [[PDServiceVC alloc] init];
    
    UINavigationController *nav2 = [[PDNavigationVC alloc] initWithRootViewController:serviceVC];
    
    [self addChildViewController:nav2];
    [self setTabbarContent:serviceVC image:[UIImage imageNamed:@"服务"] selectImg:[UIImage imageNamed:@"服务-选中"] title:@"服务"];
    
    //3.商品
    PDViewController *shopVC = [[PDShoppingVC alloc] init];
    
    UINavigationController *nav3 = [[PDNavigationVC alloc] initWithRootViewController:shopVC];
    
    [self addChildViewController:nav3];
    [self setTabbarContent:shopVC image:[UIImage imageNamed:@"商城"] selectImg:[UIImage imageNamed:@"商城-选中"] title:@"商品"];
    
    //4.税收
    PDViewController *texVC = [[PDtaxVC alloc] init];
    
    UINavigationController *nav4 = [[PDNavigationVC alloc] initWithRootViewController:texVC];
    
    [self addChildViewController:nav4];
    [self setTabbarContent:texVC image:[UIImage imageNamed:@"税收"] selectImg:[UIImage imageNamed:@"税收-选中"] title:@"税收"];
    
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

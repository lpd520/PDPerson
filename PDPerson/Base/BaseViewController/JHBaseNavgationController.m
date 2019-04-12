//
//  JHBaseNavgationController.m
//  Yacht
//
//  Created by Jonphy on 2018/12/10.
//  Copyright © 2018 Xiamen Juhu Network Techonology Co.,Ltd. All rights reserved.
//

#import "JHBaseNavgationController.h"
#import "FontAndColorMacros.h"
#import "UIColor+YYAdd.h"
#import "UIImage+YYAdd.h"
#import "UIBarButtonItem+JHExt.h"


@interface JHBaseNavgationController ()<UIGestureRecognizerDelegate>

@end

@implementation JHBaseNavgationController

#pragma mark - life cycle

- (void)dealloc{
    
}

+ (void)initialize{
    
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBarTintColor:JHNavBgColor];
    [navBar setTintColor:JHNavBgFontColor];
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName : JHNavBgFontColor, NSFontAttributeName : [UIFont systemFontOfSize:18]}];
    [navBar setBackgroundImage:[UIImage imageWithColor:JHNavBgColor] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
//    navBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate = self;
    self.interactivePopGestureRecognizer.enabled = YES;
    
    // Do any additional setup after loading the view.
}

- (void)popToViewControllerWithClassName:(NSString *)clsName animated:(BOOL)animated{
    
    Class cls = NSClassFromString(clsName);
    for (UIViewController *vc in self.viewControllers) {
        
        if ([vc isKindOfClass:cls]) {
            [self popToViewController:vc animated:animated];
            break;
        }
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    // 如果现在push的不是栈底控制器(最先push进来的那个控制器)
    if (self.viewControllers.count > 0){
        /// 统一隐藏底部tabbar
        viewController.hidesBottomBarWhenPushed = YES;
        
        /// CoderMikeHe Fixed Bug: 隐藏掉系统的返回按钮，这种方法会导致, 侧滑返回取消，导航栏会 莫名显示三个蓝点，及其恶心。但是如果不隐藏返回按钮，则会出现，你在viewController里面设置其 navigationItem.leftBarButtonItem = nil; 就会显示出系统的返回按钮。当然，出现蓝点的解决方案，在CMHViewController.m 里面，欢迎大家踊跃讨论
        [viewController.navigationItem.backBarButtonItem setTitle:@""];
//        [viewController.navigationItem setHidesBackButton:YES];
        
        // 4.这里可以设置导航栏的左右按钮 统一管理方法
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem jh_backItemWithTitle:@"" imageName:@"nav_back_white_item" target:self action:@selector(backItemDidClicked)];
    }
        [super pushViewController:viewController animated:animated];
}

- (void)backItemDidClicked{

    [self popViewControllerAnimated:YES];
}

#pragma mark - Gesture delegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    return self.childViewControllers.count > 1;
}

#pragma mark - Accessors
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
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

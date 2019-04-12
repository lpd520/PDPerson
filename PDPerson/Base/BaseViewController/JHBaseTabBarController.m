//
//  JHBaseTabBarController.m
//  Yacht
//
//  Created by Jonphy on 2018/11/9.
//  Copyright © 2018 Xiamen Juhu Network Techonology Co.,Ltd. All rights reserved.
//

#import "JHBaseTabBarController.h"
#import "UITabBar+CustomBadge.h"

typedef NS_ENUM(NSUInteger, YCTabBarItem) {
    YCTabBarItemHome,
    YCTabBarItemOrder,
    YCTabBarItemMe
};

@interface JHBaseTabBarController ()

@end

@implementation JHBaseTabBarController

#pragma mark - lifeCycle
- (void)dealloc{
    
}
    
- (instancetype)initWithNormalImageNames:(NSArray *)normalImageNames selectedImageNames:(NSArray *)selectedImageNames titles:(NSArray *)titles normalTitleColor:(UIColor *)normalTitleColor selectedTitleColor:(UIColor *)selectedTitleColor{
    
    if (self = [super init]) {
        _normalItemImages = normalImageNames;
        _selectedItemImages = selectedImageNames;
        _itemTitles = titles;
        _normalItemTitleColor = normalTitleColor;
        _selectedItemTitleColor = selectedTitleColor;
    }
    return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
     
    // Do any additional setup after loading the view.
}

#pragma mark - UITabBarDelegate

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSString *itemTitle;
    YCTabBarItem index = (YCTabBarItem)[tabBar.items indexOfObject:item];
    switch (index) {
        case YCTabBarItemHome:
            itemTitle = YCTabBarHome;
            break;
        case YCTabBarItemOrder:
            itemTitle = YCTabBarOrder;
            break;
        case YCTabBarItemMe:
            itemTitle = YCTabBarMe;
            break;
    }
    [TalkingData trackEvent:itemTitle];
}

#pragma mark - public methods
- (void)configureTabControllerWithViewControllers:(NSArray *)controllers{
    
    for (NSUInteger i = 0; i < controllers.count; i ++) {
        
        UIViewController *controller = controllers[i];
        NSString *norImgName = _normalItemImages[i];
        NSString *selImgName = _selectedItemImages[i];
        controller.tabBarItem.image = [[UIImage imageNamed:norImgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        controller.tabBarItem.selectedImage = [[UIImage imageNamed:selImgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal
                                            ];
        controller.tabBarItem.title = _itemTitles[i];
    }
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : _normalItemTitleColor} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : _selectedItemTitleColor} forState:UIControlStateSelected];
    self.viewControllers = controllers;
}

- (void)setRedDotWithIndex:(NSInteger)index isShow:(BOOL)isShow{
 
    if (isShow) {
        [self.tabBar setBadgeStyle:kCustomBadgeStyleRedDot value:0 atIndex:index];
    }else{
        [self.tabBar setBadgeStyle:kCustomBadgeStyleNone value:0 atIndex:index];
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

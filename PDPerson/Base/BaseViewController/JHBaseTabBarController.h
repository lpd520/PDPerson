//
//  JHBaseTabBarController.h
//  Yacht
//
//  Created by Jonphy on 2018/11/9.
//  Copyright © 2018 Xiamen Juhu Network Techonology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JHBaseTabBarController : UITabBarController

@property (nonatomic, copy) NSArray *normalItemImages;
@property (nonatomic, copy) NSArray *selectedItemImages;
@property (nonatomic, copy) NSArray *itemTitles;
@property (nonatomic, strong) UIColor *normalItemTitleColor;
@property (nonatomic, strong) UIColor *selectedItemTitleColor;

- (instancetype)initWithNormalImageNames:(NSArray *)normalImageNames selectedImageNames:(NSArray *)selectedImageNames titles:(NSArray *)titles normalTitleColor:(UIColor *)normalTitleColor selectedTitleColor:(UIColor *)selectedTitleColor;

- (void)configureTabControllerWithViewControllers:(NSArray *)controllers;
/**
 设置小红点
 
 @param index tabbar下标
 @param isShow 是显示还是隐藏
 */
-(void)setRedDotWithIndex:(NSInteger)index isShow:(BOOL)isShow;

@end

NS_ASSUME_NONNULL_END

//
//  PDViewController.h
//  PDPerson
//
//  Created by mac on 2018/10/7.
//  Copyright © 2018年 QingYe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDViewController : UIViewController


/// 反向传值block
@property (nonatomic, readwrite, copy) void (^callBackDataBlock)(id);




-(void)pushToVC:(UIViewController *)vc;
-(void)popVC;

-(void)clickLeftNavbarButtonItem;
-(void)clickRightNavbarButtonItem;

/// 基础配置 （子类可以重写，重写时须调用 [super configure]）
- (void)configure;

- (void)fetchData;


@end

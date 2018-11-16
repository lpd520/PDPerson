//
//  UIAlertController+PD.h
//  HaiTian
//
//  Created by mac on 2018/4/21.
//  Copyright © 2018年 wyj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (PD)


+(UIAlertController *)alertWithTipMessage:(NSString *)title
                              subTitle:(NSString *)detail
                               okBlock:(void (^)(void))aBlock
                               noBlock:(void (^)(void))bBlock;


+(UIAlertController *)bottomSheetWithTipMessage:(NSString *)title
                                   subTitle:(NSString *)detail
                                       tab1:(NSString *)choice1
                                       tab2:(NSString *)choice2
                                  tab1Block:(void (^)(void))aBlock
                                  tab2Block:(void (^)(void))bBlock;



@end

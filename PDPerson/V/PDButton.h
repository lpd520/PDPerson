//
//  PDButton.h
//  PDPerson
//
//  Created by qingye on 2019/3/12.
//  Copyright © 2019 QingYe. All rights reserved.
//  子控件位置 自定义调整

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger,PDButtonType) {
    
    PDButtonTypeImageTitleBothCenter,  //图片，文字都居中
    PDButtonTypeLeftTitleRightImage,    //图片右，文字左
    PDButtonTypeLeftImageNoneTitle,    //图片左，文字无
    
};



@interface PDButton : UIButton


@property (nonatomic, assign) PDButtonType type;

+ (instancetype)pdButtonWithType:(PDButtonType)buttonType;


- (void)updateButtonStyleWithType:(PDButtonType)buttonType;



@end

NS_ASSUME_NONNULL_END

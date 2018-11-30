//
//  PDLoadingView.h
//  PDPerson
//
//  Created by mac on 2018/11/30.
//  Copyright © 2018年 QingYe. All rights reserved.
//  图片加载进度 提示

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger,PDLoadingViewType) {
    PDLoadingViewTypeLoopDiagram = 0, // 环形
    PDLoadingViewTypePieDiagram    // 饼型
};


@interface PDLoadingView : UIView


/**
 加载进度
 */
@property (nonatomic, assign) double progress;

/**
 加载进度图形的样式 （环形和饼形）
 */
@property (nonatomic, assign) PDLoadingViewType type;



- (id)initWithLoadingType:(PDLoadingViewType)type;


@end

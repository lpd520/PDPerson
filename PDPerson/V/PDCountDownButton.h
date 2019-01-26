//
//  PDCountDownButton.h
//  ChuanRen
//
//  Created by qingye on 2018/12/22.
//  Copyright © 2018 qingye. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PDCountDownButton : UIButton

@property(nonatomic,strong)NSString *finishedText;
@property(nonatomic,strong)NSString *showText;



-(instancetype)initWithTitle:(NSString *)title;

-(void)btnBeginCountDownWithTime:(NSInteger)timeInterval;

@end

NS_ASSUME_NONNULL_END

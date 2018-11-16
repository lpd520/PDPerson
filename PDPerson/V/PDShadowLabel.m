//
//  PDShadowLabel.m
//  HaiTian
//
//  Created by mini on 2018/4/19.
//  Copyright © 2018年 wyj. All rights reserved.
//

#import "PDShadowLabel.h"

@implementation PDShadowLabel

-(instancetype)initWithText:(NSString *)text{
    
    if(self = [super init]){
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        self.layer.shadowOpacity = 0.8f;
        self.layer.shadowOffset = CGSizeMake(0,0);
        
        [self.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [self.layer setBorderWidth:0.5];
        
        UILabel *lb = [UILabel labelWithText:text Font:15. TextColor:[UIColor blackColor]];
        lb.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo(self);
        }];
    }
    
    return self;
}


@end

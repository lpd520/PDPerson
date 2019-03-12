//
//  PDButton.m
//  PDPerson
//
//  Created by qingye on 2019/3/12.
//  Copyright © 2019 QingYe. All rights reserved.
//

#import "PDButton.h"

@implementation PDButton

+ (instancetype)pdButtonWithType:(PDButtonType)buttonType {
    
    PDButton * btn = [PDButton buttonWithType:UIButtonTypeCustom];
    btn.type = buttonType;
    
    return btn;
}

- (void)updateButtonStyleWithType:(PDButtonType)buttonType {
    
    self.type = buttonType;
    [self layoutSubviews];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.type == PDButtonTypeImageTitleBothCenter) {
        [self resetBtnCenterImageCenterTitle];
    } else if (self.type == PDButtonTypeLeftImageNoneTitle) {
        [self resetBtnLeftImageNotTitle];
    } else if (self.type == PDButtonTypeLeftTitleRightImage) {
        [self resetBtnRightImageLeftTitle];
    }
}



- (void)resetBtnCenterImageCenterTitle {
    
    self.imageView.frame = self.bounds;
    [self.imageView setContentMode:UIViewContentModeCenter];
    
    self.titleLabel.frame = self.bounds;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)resetBtnLeftImageNotTitle {
    
    CGRect frame = self.bounds;
    frame.size.width *= 0.5;
    self.imageView.frame = frame;
    [self.imageView setContentMode:UIViewContentModeCenter];
    
    self.titleLabel.frame = CGRectZero;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)resetBtnRightImageLeftTitle {
    
    CGRect frame = self.bounds;
    frame.size.width *= 0.5;
    self.titleLabel.frame = frame;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    frame.origin.x = (self.bounds.size.width - frame.size.width);
    self.imageView.frame = frame;
    [self.imageView setContentMode:UIViewContentModeCenter];
}


@end

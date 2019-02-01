//
//  MSSAutoresizeLabelFlowCell.m
//  MSSAutoresizeLabelFlow
//
//  Created by Mrss on 15/12/26.
//  Copyright © 2015年 expai. All rights reserved.
//

#import "MSSAutoresizeLabelFlowCell.h"
#import "MSSAutoresizeLabelFlowConfig.h"
#define JKColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
@interface MSSAutoresizeLabelFlowCell ()

@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation MSSAutoresizeLabelFlowCell

-(void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    
    self.titleLabel.backgroundColor = _isSelected?mainThemeGreen:[UIColor whiteColor];
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.backgroundColor = [MSSAutoresizeLabelFlowConfig shareConfig].itemColor;
        _titleLabel.textColor = [MSSAutoresizeLabelFlowConfig shareConfig].textColor;
        _titleLabel.font      = [MSSAutoresizeLabelFlowConfig shareConfig].textFont;
        _titleLabel.layer.cornerRadius = [MSSAutoresizeLabelFlowConfig shareConfig].itemCornerRaius;
        _titleLabel.layer.masksToBounds = YES;
        _titleLabel.layer.borderColor = JKColor(220, 220, 220, 1.0).CGColor;
        _titleLabel.layer.borderWidth = 0.5;
        _titleLabel.textAlignment = NSTextAlignmentCenter;

    }
    return _titleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)configCellWithTitle:(NSString *)title {
    self.titleLabel.frame = self.bounds;
    self.titleLabel.text = title;
}

//-(void)setSelected:(BOOL)selected{
//    isSelected = !isSelected;
//
//    if (isSelected) {
//        NSLog(@"ssss");
//    }else
//        NSLog(@"nnnn");
//}

@end

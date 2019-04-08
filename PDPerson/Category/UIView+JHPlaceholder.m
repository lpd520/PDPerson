//
//  UIView+JHPlaceholder.m
//  Yacht
//
//  Created by Jonphy on 2019/1/16.
//  Copyright © 2019 Xiamen Juhu Network Techonology Co.,Ltd. All rights reserved.
//

#import "UIView+JHPlaceholder.h"
#import "Masonry.h"

static NSString *JHEnableClickToReloadKey = @"enableClickToReload";
static NSString *JHPlaceholderViewKey = @"placeholderView";

@implementation UIView (JHPlaceholder)

- (void)setEnableClickToReload:(BOOL)enableClickToReload{
    objc_setAssociatedObject(self, &JHEnableClickToReloadKey, @(enableClickToReload), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)enableClickToReload{
    
    NSNumber *value = objc_getAssociatedObject(self, &JHEnableClickToReloadKey);
    return [value boolValue];
}

- (void)setPlaceholderView:(UIView * _Nullable)placeholderView{
    
    objc_setAssociatedObject(self, &JHPlaceholderViewKey, placeholderView, OBJC_ASSOCIATION_RETAIN);
}

- (UIView *)placeholderView{
    
    return  objc_getAssociatedObject(self, &JHPlaceholderViewKey);
}

- (void)showPlaceholderViewWithImage:(UIImage *)image text:(NSString *)desc {
    
    if (self.placeholderView) {
        [self.placeholderView removeFromSuperview];
        self.placeholderView = nil;
    }
    
    self.placeholderView = [[UIView alloc]initWithFrame:self.bounds];
    self.placeholderView.backgroundColor = self.backgroundColor;
    [self addSubview:self.placeholderView];
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
    [self.placeholderView addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self.placeholderView);
    }];
    
    UILabel *descLb = [[UILabel alloc] init];
    descLb.text = desc;
    descLb.textColor = [UIColor grayColor];
    descLb.font = JHFont2;
    [self.placeholderView addSubview:descLb];
    [descLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgView.mas_bottom).offset(20);
        make.centerX.equalTo(imgView);
    }];
}

- (void)removePlacehoderView{
    
    if (self.placeholderView) {
        [self.placeholderView removeFromSuperview];
        self.placeholderView = nil;
    }
}

@end

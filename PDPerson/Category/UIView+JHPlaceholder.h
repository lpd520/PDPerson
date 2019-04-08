//
//  UIView+JHPlaceholder.h
//  Yacht
//
//  Created by Jonphy on 2019/1/16.
//  Copyright © 2019 Xiamen Juhu Network Techonology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (JHPlaceholder)

@property (nonatomic, readonly, assign) BOOL enableClickToReload;
@property (nonatomic, readonly, strong) UIView *placeholderView;

- (void)showPlaceholderViewWithImage:(UIImage * _Nullable)image text:(NSString *)desc;
- (void)removePlacehoderView;

@end

NS_ASSUME_NONNULL_END

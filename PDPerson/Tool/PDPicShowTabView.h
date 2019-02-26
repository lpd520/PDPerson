//
//  PDPicShowTabView.h
//  JinShan
//
//  Created by qingye on 2019/2/13.
//  Copyright © 2019 qingye. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PDPicShowTabView : UIView

@property(nonatomic,strong)NSMutableArray *imgUrls;
@property(nonatomic,strong)NSString *imgUrlStrings;

@property(nonatomic,strong)NSMutableArray *imgs;

-(instancetype)initWithTabTitle:(NSString *)text;


@end

NS_ASSUME_NONNULL_END

//
//  PDPicTabView.h
//  JinShan
//
//  Created by qingye on 2018/1/2.
//  Copyright © 2018 qingye. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,PDSelectContentType) {
    PDSelectContentTypeImage = 0,
    PDSelectContentTypeVideo
};



@interface PDPicSelectTabView : UIView


@property(nonatomic,strong)NSMutableArray *imgUrls;
@property(nonatomic,strong)NSString *imgUrlStrings;

@property(nonatomic,strong)NSMutableArray *imgs;

@property(nonatomic,assign)PDSelectContentType type;
@property(nonatomic,assign)BOOL onlyRead;


-(instancetype)initWithTabTitle:(NSString *)text;


@end

NS_ASSUME_NONNULL_END

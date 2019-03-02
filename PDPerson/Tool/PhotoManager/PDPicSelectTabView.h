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


typedef NS_ENUM(NSUInteger,PDSelectEnableType) {
    PDSelectEnableTypeShow = 0,   // 只能预览
    PDSelectEnableTypeSelect     // 可以选图
};

@interface PDPicSelectTabView : UIView


@property(nonatomic,strong)NSMutableArray *imgUrlArray;
@property(nonatomic,strong)NSString *imgUrlStrings;

//@property(nonatomic,strong)NSMutableArray *imgs;

// 视频、照片
@property(nonatomic,assign)PDSelectContentType selectContentType;

@property(nonatomic,assign)PDSelectEnableType selectEnableType;


-(instancetype)initWithTabTitle:(NSString *)text SelectEnableType:(PDSelectEnableType)type;

-(void)reloadViewData;

// 从字符串中得到数组   （，分隔）
+(NSMutableArray *)arrayFromString:(NSString *)urls;



@end

NS_ASSUME_NONNULL_END

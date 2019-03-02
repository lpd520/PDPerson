//
//  PDImageItem.h
//  JinShan
//
//  Created by qingye on 2018/1/2.
//  Copyright © 2018 qingye. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class  PDImageItem;
@protocol PDImageItemSelectDelegate <NSObject>

-(void)didDeletedImageItemOnCell:(PDImageItem *)cell atIndex:(NSUInteger)row;

@end

@interface PDImageItem : UICollectionViewCell

@property(nonatomic,strong)NSString *imageUrl;
@property(nonatomic,strong)UIImage  *image;

@property(nonatomic,assign)BOOL hideDeleted;


@property(nonatomic,weak)id<PDImageItemSelectDelegate> delegate;


@end

NS_ASSUME_NONNULL_END

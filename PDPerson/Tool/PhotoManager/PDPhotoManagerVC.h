//
//  PDPhotoManagerVC.h

//
//  Created by mac on 2018/8/2.
//  Copyright © 2018年 QingYe. All rights reserved.
//


#import "PDViewController.h"


typedef NS_ENUM(NSUInteger, photoType) {
    photoTypeDefault = 0,
    photoTypeUserHeader,
};

@interface PDPhotoManagerVC : PDViewController

@property(nonatomic,assign)NSInteger photoType;

@property(nonatomic,strong)void (^imgURLCallbackBlock)(NSString *url);

-(void)beginChoosePhotoFromAlbums;

-(void)beginTakePhotoWithCamera;

@end

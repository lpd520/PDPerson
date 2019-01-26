//
//  PDTabsContentVC.h
//  JinJing
//
//  Created by mac on 2018/7/14.
//  Copyright © 2018年 QingYe. All rights reserved.
//

#import "PDViewController.h"
#import "FSScrollContentView.h"


@interface PDTabsContentVC : PDViewController<FSPageContentViewDelegate,FSSegmentTitleViewDelegate>

@property (nonatomic, strong) NSMutableArray *childVCs;

@property (nonatomic, readonly, strong) FSPageContentView *pageContentView;
@property (nonatomic, readonly, strong) FSSegmentTitleView *titleView;

@property (nonatomic, assign) float titleView_y;


-(void)setupScrollContentView;

- (instancetype)initWithTitleArr:(NSArray *)vcTitles;

-(void)changeF;


@end

//
//  PDTabsContentVC.m
//  JinJing
//
//  Created by mac on 2018/7/14.
//  Copyright © 2018年 QingYe. All rights reserved.
//

#import "PDTabsContentVC.h"

@interface PDTabsContentVC ()

@property (nonatomic, readwrite, strong) FSPageContentView *pageContentView;
@property (nonatomic, readwrite, strong) FSSegmentTitleView *titleView;

@property (nonatomic, strong) NSArray *titleArr;

@end

@implementation PDTabsContentVC

-(NSMutableArray *)childVCs{
    if (!_childVCs) {
        _childVCs = [NSMutableArray arrayWithCapacity:0];
    }
    return  _childVCs;
}

- (instancetype)initWithTitleArr:(NSArray *)vcTitles{
    if (self = [super init]) {

        self.titleArr = vcTitles;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}


-(void)setupScrollContentView{
    
    float y0 = self.titleView_y?self.titleView_y:kNavBarHeight;
    
    CGRect viewFrame = CGRectMake(0, y0, SCREEN_W, 45);
    // 添加标题栏
    self.titleView = [[FSSegmentTitleView alloc] initWithFrame:viewFrame titles:self.titleArr delegate:self indicatorType:FSIndicatorTypeEqualTitle];
    self.titleView.titleSelectColor = mainThemeRed;
    self.titleView.titleSelectFont = [UIFont systemFontOfSize:15];
    self.titleView.selectIndex = 0;
    [self.view addSubview:_titleView];
    [self.titleView moveIndicatorView:YES];
    
    //  添加子控制器
    //...
    
    float y1 = CGRectGetMaxY(self.titleView.frame);
    CGRect vcFrame = CGRectMake(0, y1, SCREEN_W, SCREEN_H - y1);
    
    self.pageContentView = [[FSPageContentView alloc]initWithFrame:vcFrame childVCs:self.childVCs parentVC:self delegate:self];
    
    self.pageContentView.contentViewCurrentIndex = 0;
    self.pageContentView.contentViewCanScroll = YES;//设置滑动属性
    [self.view addSubview:_pageContentView];
    
}

-(void)changeF{
    
    CGRect f = self.pageContentView.frame;
    
    [UIView animateWithDuration:.3 animations:^{
        
        if (f.origin.y == self.titleView.frame.origin.y) {
            [self.pageContentView setFrame:CGRectMake(0, f.origin.y+45, SCREEN_W, f.size.height)];
            
        }else
            [self.pageContentView setFrame:CGRectMake(0, f.origin.y-45, SCREEN_W, f.size.height)];
    }];
    
}

-(void)configure{
    
    [super configure];
    
}

#pragma mark --
- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    self.pageContentView.contentViewCurrentIndex = endIndex;
    //    self.title = self.titleArr[endIndex];
}

- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex{
    self.titleView.selectIndex = endIndex;
    //    self.title = self.titleArr[endIndex];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end

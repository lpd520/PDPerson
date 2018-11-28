//
//  PDTableViewController.m
//  PDPerson
//
//  Created by mac on 2018/10/7.
//  Copyright © 2018年 QingYe. All rights reserved.
//

#import "PDTableViewController.h"

@interface PDTableViewController ()

@end

@implementation PDTableViewController


-(NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}
-(NSMutableArray *)headerArray{
    if (!_headerArray) {
        _headerArray = [NSMutableArray array];
    }
    return _headerArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configure];
    
    [self configureTableView];
    
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:self.style];
    self.myTableView.backgroundColor = [UIColor whiteColor];
    self.myTableView.frame = CGRectMake(0, kNavBarHeight, SCREEN_W, SCREEN_H-kNavBarHeight-kSafeBottomMargin);
    self.myTableView.tableFooterView = [[UIView alloc] init];
    self.myTableView.showsVerticalScrollIndicator = NO;
    self.myTableView.showsHorizontalScrollIndicator = NO;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.myTableView.separatorColor = separatorLineGray;
    
    //代理
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    
    [self.view addSubview:self.myTableView];
}

-(void)fetchData{
    
    [self.dataList addObject:@""];
    [self.dataList addObject:@""];
}

-(void)configureTableView{
    
    self.style = UITableViewStylePlain;
    [self.myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.headerArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

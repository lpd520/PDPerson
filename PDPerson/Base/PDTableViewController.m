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
    
    
    [self.view addSubview:self.myTableView];
    
//    [self fetchData];
    [self.myTableView reloadData];
    
}


-(void)fetchData{
    
    [self.dataList addObject:@"xxxxxxxxx"];
    [self.dataList addObject:@"xxxxxxxxx"];
    [self.dataList addObject:@"xxxxxxxxx"];
    [self.dataList addObject:@"xxxxxxxxx"];
    [self.dataList addObject:@"xxxxxxxxx"];
    [self.dataList addObject:@"xxxxxxxxx"];
    [self.dataList addObject:@"xxxxxxxxx"];
    [self.dataList addObject:@"xxxxxxxxx"];
    [self.dataList addObject:@"xxxxxxxxx"];
    [self.dataList addObject:@"xxxxxxxxx"];
    [self.dataList addObject:@"xxxxxxxxx"];
    [self.dataList addObject:@"xxxxxxxxx"];
    [self.dataList addObject:@"xxxxxxxxx"];
    [self.dataList addObject:@"xxxxxxxxx"];
    [self.dataList addObject:@"xxxxxxxxx"];
    [self.dataList addObject:@"xxxxxxxxx"];
    [self.dataList addObject:@"xxxxxxxxx"];
    [self.dataList addObject:@"xxxxxxxxx"];
    [self.dataList addObject:@"xxxxxxxxx"];
    [self.dataList addObject:@"xxxxxxxxx"];

}

-(void)configureTableView{
    
    self.style = UITableViewStylePlain;

    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, SCREEN_W, SCREEN_H-kNavBarHeight-kSafeBottomMargin) style:self.style];
    self.myTableView.backgroundColor = [UIColor whiteColor];
    //    self.myTableView.frame = CGRectMake(0, kNavBarHeight, SCREEN_W, SCREEN_H-kNavBarHeight-kSafeBottomMargin);
    self.myTableView.tableFooterView = [[UIView alloc] init];
    self.myTableView.showsVerticalScrollIndicator = NO;
    self.myTableView.showsHorizontalScrollIndicator = NO;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.myTableView.separatorColor = separatorLineGray;
    [self.myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    //代理
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
}

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return self.headerArray.count;
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = self.dataList.count>0?[self.dataList objectAtIndex:indexPath.row]:@"xx";
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

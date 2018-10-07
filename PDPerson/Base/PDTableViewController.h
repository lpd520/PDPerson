//
//  PDTableViewController.h
//  PDPerson
//
//  Created by mac on 2018/10/7.
//  Copyright © 2018年 QingYe. All rights reserved.
//

#import "PDViewController.h"

@interface PDTableViewController : PDViewController<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)UITableView *myTableView;
@property(nonatomic,strong)NSMutableArray *dataList;
@property(nonatomic,strong)NSMutableArray *headerArray;

@property(nonatomic,assign)UITableViewStyle style;


-(void)configureTableView;



@end

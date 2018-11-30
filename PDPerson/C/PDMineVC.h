//
//  PDMineVC.h
//  PDPerson
//
//  Created by mac on 2018/10/8.
//  Copyright © 2018年 QingYe. All rights reserved.
//

#import "PDTableViewController.h"

@interface PDMineVC : PDTableViewController

@property(nonatomic,strong)void (^rebackBlock)(NSString *flag);


@end

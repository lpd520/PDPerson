//
//  UIAlertController+PD.m
//  HaiTian
//
//  Created by mac on 2018/4/21.
//  Copyright © 2018年 wyj. All rights reserved.
//

#import "UIAlertController+PD.h"

@implementation UIAlertController (PD)



+(UIAlertController *)alertWithTipMessage:(NSString *)title subTitle:(NSString *)detail okBlock:(void (^)(void))aBlock noBlock:(void (^)(void))bBlock{
    
    //1、创建弹框
    UIAlertController *aler = [UIAlertController alertControllerWithTitle:title message:detail preferredStyle:UIAlertControllerStyleAlert];
    //2、创建按钮
    UIAlertAction *alerBtn1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if(aBlock)
            aBlock();    // 确定的相关处理
        
        return ;
    }];
    //3、创建确定按钮
    UIAlertAction *alerBtn2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        if(bBlock)
            bBlock();   // 取消的相关处理
        
        return ;
    }];
    
    if( !aBlock && !bBlock){
        [aler addAction:alerBtn1];   //确定、取消block 都没有
        return aler;
    }
    
    [aler addAction:alerBtn1];
    [aler addAction:alerBtn2];
    
    return aler;
}


+(UIAlertController *)bottomSheetWithTipMessage:(NSString *)title subTitle:(NSString *)detail tab1:(NSString *)choice1 tab2:(NSString *)choice2 tab1Block:(void (^)(void))aBlock tab2Block:(void (^)(void))bBlock{
    
    //1、创建弹框
    UIAlertController *aler = [UIAlertController alertControllerWithTitle:title message:detail preferredStyle:UIAlertControllerStyleActionSheet];
    //2、创建按钮
    UIAlertAction *alerBtn1 = [UIAlertAction actionWithTitle:choice1 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        aBlock();    // 相关处理1
        return ;
    }];
    
    UIAlertAction *alerBtn2 = [UIAlertAction actionWithTitle:choice2 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        bBlock();   // 相关处理2
        return ;
    }];
    UIAlertAction *alerBtn3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        return ;
    }];
    
    [aler addAction:alerBtn2];
    [aler addAction:alerBtn1];
    
    [aler addAction:alerBtn3];
    
    return aler;
}



@end

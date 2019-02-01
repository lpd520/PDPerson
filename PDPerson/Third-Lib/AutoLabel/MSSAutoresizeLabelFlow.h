//
//  MSSAutoresizeLabelFlow.h
//  MSSAutoresizeLabelFlow
//
//  Created by Mrss on 15/12/26.
//  Copyright © 2015年 expai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectedHandler)(NSUInteger index,NSString *title);

@interface MSSAutoresizeLabelFlow : UIView

@property (nonatomic,strong) NSMutableArray   *data;


- (instancetype)initWithFrame:(CGRect)frame
                       titles:(NSArray *)titles
              selectedHandler:(selectedHandler)handler;



// 插入
- (void)insertLabelWithTitle:(NSString *)title
                     atIndex:(NSUInteger)index
                    animated:(BOOL)animated;

- (void)insertLabelsWithTitles:(NSArray *)titles
                     atIndexes:(NSIndexSet *)indexes
                      animated:(BOOL)animated;


// 删除
- (void)deleteLabelAtIndex:(NSUInteger)index
                  animated:(BOOL)animated;

- (void)deleteLabelsAtIndexes:(NSIndexSet *)indexes
                     animated:(BOOL)animated;




- (void)reloadAllWithTitles:(NSArray *)titles;


@end





//
//  JHBaseNavgationController.h
//  Yacht
//
//  Created by Jonphy on 2018/12/10.
//  Copyright © 2018 Xiamen Juhu Network Techonology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JHBaseNavgationController : UINavigationController

- (void)popToViewControllerWithClassName:(NSString *)clsName animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END

//
//  PDWebViewController.h
//  PDPerson
//
//  Created by mac on 2018/10/8.
//  Copyright © 2018年 QingYe. All rights reserved.
//

#import "PDViewController.h"
#import <WebKit/WebKit.h>

@interface PDWebViewController : PDViewController<WKNavigationDelegate,WKUIDelegate,UIScrollViewDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong, readonly) WKWebView *webView;
@property (nonatomic, readwrite, copy) NSString *requestURL;
@property (nonatomic, readwrite, copy) NSString *htmlString;

@end

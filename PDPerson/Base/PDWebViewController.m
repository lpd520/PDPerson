//
//  PDWebViewController.m
//  PDPerson
//
//  Created by mac on 2018/10/8.
//  Copyright © 2018年 QingYe. All rights reserved.
//

#import "PDWebViewController.h"

@interface PDWebViewController ()

@property(nonatomic,strong)WKWebView *webView;


@end

@implementation PDWebViewController

-(WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
        _webView.UIDelegate = self;                // UI代理
        _webView.navigationDelegate = self;        // 导航代理
        _webView.scrollView.delegate = self;
//        _webView.allowsBackForwardNavigationGestures = YES;  // 左滑返回

        self.extendedLayoutIncludesOpaqueBars = YES;
        if (@available(iOS 11.0, *)) {
            _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
        }
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchWebView)];
//        tap.delegate = self;
//        [_webView.scrollView addGestureRecognizer:tap];
        
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configure];
    
    [self loadWebContent];
    [self.view addSubview:self.webView];
    
}

-(void)loadWebContent{
    
    if (self.requestURL) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.requestURL]]];
    }
    else{
        [self.webView loadHTMLString:self.htmlString baseURL:nil];
    }
}

-(void)configure{
    [super configure];
    
    self.title = @"网页详情";
}

-(void)clickLeftNavbarButtonItem{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
        return ;
    }
    [SVProgressHUD dismiss];
    [self popVC];
}

#pragma mark - WKNavigationDelegate
 // 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
    
}

// 加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
}
// 加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    
    [SVProgressHUD showNOmessage:@"网页内容加载失败"];
}

//  在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
//    decisionHandler(YES);
}

// 在收到响应后，决定是否跳转
-(void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(nonnull WKNavigationResponse *)navigationResponse decisionHandler:(nonnull void (^)(WKNavigationResponsePolicy))decisionHandler{
    
}

//接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
}



#pragma mark - WKUIDelegate 网页弹窗
// 显示一个JS的Alert（与JS交互）
-(void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    completionHandler();   // must
}
// 显示一个确认框（JS的）
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    completionHandler(NO);
}
// 弹出一个输入框（与JS交互的）
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    
    completionHandler(@"x");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end

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
@property(nonatomic,strong)CALayer *progressLayer;


@end

static NSInteger progressHeight = 2;
static NSString *progressKey = @"estimatedProgress";


@implementation PDWebViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configure];
    
    [self.view addSubview:self.webView];
    
    //添加进度条
    [self addWebviewProgressView];
    
    [self loadWebContent];

}


-(void)addWebviewProgressView{
    
    UIView *progress = [[UIView alloc]initWithFrame:CGRectMake(0, 64, 0, progressHeight)];
    progress.backgroundColor = [UIColor greenColor];
    [self.view addSubview:progress];
    [progress.layer addSublayer:self.progressLayer];
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

#pragma mark - 监听加载进度
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:progressKey]) {
        
        float f =  [change[NSKeyValueChangeNewKey] floatValue];
        NSLog(@"#####>>%f",f);
        self.progressLayer.opacity = 1;
        self.progressLayer.frame = CGRectMake(0, 0, SCREEN_W * f, progressHeight);
        if (f == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressLayer.opacity = 0;
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressLayer.frame = CGRectMake(0, 0, 0, progressHeight);
            });
        }
        
        
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
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

//    [SVProgressHUD showNOmessage:@"网页内容加载失败"];
}

//  在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{

    decisionHandler(YES);  // must
}

// 在收到响应后，决定是否跳转
-(void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(nonnull WKNavigationResponse *)navigationResponse decisionHandler:(nonnull void (^)(WKNavigationResponsePolicy))decisionHandler{

    decisionHandler(YES);  // must
}
//
////接收到服务器跳转请求之后调用
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

- (void)dealloc{
    [self.webView removeObserver:self forKeyPath:progressKey];
}


-(CALayer *)progressLayer{
    if (!_progressLayer) {
        _progressLayer = [CALayer layer];
        _progressLayer.frame = CGRectMake(0, 0, 0, progressHeight);
        _progressLayer.backgroundColor = [UIColor greenColor].CGColor;
    }
    return _progressLayer;
}

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
        
        //添加属性监听
        [_webView addObserver:self forKeyPath:progressKey options:NSKeyValueObservingOptionNew context:nil];
        
    }
    return _webView;
}




@end

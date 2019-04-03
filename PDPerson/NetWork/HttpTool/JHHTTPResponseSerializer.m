//
//  POHTTPResponseSerializer.m
//  Yacht
//
//  Created by Jonphy on 2018/11/8.
//  Copyright © 2018 Xiamen Juhu Network Techonology Co.,Ltd. All rights reserved.
//

#import "JHHTTPResponseSerializer.h"
#import "JHNetworkConstant.h"
#import "SVProgressHUD.h"
#import "JHBaseRequest.h"
#import "JHDataConvertion.h"
//#import "SecurityUtil.h"


@implementation JHHTTPResponseSerializer

- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing  _Nullable *)error{
    
    id responseObject = [super responseObjectForResponse:response data:data error:error];
     NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    DLog(@"NSURLResponseURL:%@ code:%ld",response.URL,httpResponse.statusCode);
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
    
    NSError *jsError;
    NSString *dataString = [[NSString  alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    NSDictionary *dic;
    if (dataString &&[response.URL.path isEqualToString:@"/api/pay/ali-pay"]) {
        dic = @{@"data":dataString,ApiResponseKeyMsg:@"创建支付宝订单成功"};
        return dic;
    }
    
    JHDataConvertion *convertion = [[JHDataConvertion alloc] init];
    dic = [convertion dictionaryWithJsonString:dataString];
    
    DLog(@"parse dic:%@",dic);
    if (!dic || ![dic isKindOfClass:[NSDictionary class]]|| jsError) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
        });
        return nil;
    }
    
   
    NSInteger code = httpResponse.statusCode;
    if (code == ApiSessionSucessCode) {
        return dic;
    }else{
        
        if (code == ApiAccountErrorLogoutCode) {
            
        }
        NSString *msg = dic[@"message"];
        [SVProgressHUD showErrorWithStatus:msg];
        return nil;
    }
    return dic;
}

@end

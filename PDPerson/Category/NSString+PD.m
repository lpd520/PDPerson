//
//  NSString+PD.m
//  AnYue
//
//  Created by mac on 2018/5/17.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "NSString+PD.h"

@implementation NSString (PD)

// 字典转json String
+ (NSString *)dictionaryToJsonString:(NSDictionary *)dict {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&parseError];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSMutableString *tempString = [NSMutableString stringWithString:jsonStr];
    NSString *attachString = [tempString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    return attachString;
}

// arr  -->  string
+ (NSString *)arrayToJsonString:(NSArray *)array {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:0 error:&parseError];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSMutableString *tempString = [NSMutableString stringWithString:jsonStr];
    NSString *attachString = [tempString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    return attachString;
}


-(BOOL)isNull{
    
    if (!self) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (!self.length) {
        return YES;
    }
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedStr = [self stringByTrimmingCharactersInSet:set];
    if (!trimmedStr.length) {
        return YES;
    }
    
    return NO;
}


-(BOOL)isHasChinese{
    
    for (int i=0; i<self.length; ++i) {
        
        NSRange range =NSMakeRange(i, 1);
        NSString * strFromSubStr=[self substringWithRange:range];
        const char *cStringFromstr = [strFromSubStr UTF8String];
        
        if (strlen(cStringFromstr)==3) {
            //汉字
            return YES;
        } else if (strlen(cStringFromstr)==1) {
            //字母
        }
    }
    return NO;
}

-(void)deleteAllSpace{
    if([self containsString:@" "]){
        [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
}



+(NSString *)decodeHasChineseWithStr:(NSString *)str{
    
    return  [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

#pragma --- 正则表达式 ---
// 判断是否手机号码
+(BOOL)checkForMobilePhoneYES:(NSString *)mobilePhone{
    
    NSString *regEx = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    return [self baseCheckForRegEx:regEx data:mobilePhone];
}
// 判断是否 Email
+(BOOL)checkForEmailYES:(NSString *)email{
    
    NSString *regEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self baseCheckForRegEx:regEx data:email];
}

+(BOOL)baseCheckForRegEx:(NSString *)regEx data:(NSString *)data{
    
    NSPredicate *card = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    
    if (([card evaluateWithObject:data])) {
        return YES;
    }
    return NO;
}

+ (NSString *)creatRadomString{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRST";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand(time(0));
    for (int i = 0; i < kNumber; ++i)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}


+ (NSArray *)getURLFromString:(NSString *)string {
    
    NSError *error;
    //可以识别url的正则表达式
    NSString *regulaStr = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    NSArray *arrayOfAllMatches = [regex matchesInString:string
                                                options:0
                                                  range:NSMakeRange(0, [string length])];
    
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    
    for (NSTextCheckingResult *match in arrayOfAllMatches){
        NSString* substringForMatch;
        substringForMatch = [string substringWithRange:match.range];
        [arr addObject:substringForMatch];
    }
    return arr;
}

@end

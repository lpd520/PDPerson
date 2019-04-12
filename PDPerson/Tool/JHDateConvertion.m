//
//  JHDateConvertion.m
//  Yacht
//
//  Created by Jonphy on 2019/3/5.
//  Copyright © 2019 Xiamen Juhu Network Techonology Co.,Ltd. All rights reserved.
//

#import "JHDateConvertion.h"

@implementation JHDateConvertion


+ (NSString *)dateWithSeconds:(NSUInteger)sec{
    
    NSUInteger secondUnit = sec % 60;
    NSUInteger minuteUnit = sec / 60 % 60;
    NSUInteger hourUnit = sec / 60 / 60 % 24;
    NSUInteger dayUnit = sec / 60 / 60 / 24;
    
    NSString *secondUnitS = @"00";
    NSString *minuteUnitS = @"00";
    NSString *hourUnitS = @"00";
    NSString *dayUnitS = @"";
    
    secondUnitS = @(secondUnit).stringValue;
    minuteUnitS = @(minuteUnit).stringValue;
    hourUnitS = @(hourUnit).stringValue;
    dayUnitS = @(dayUnit).stringValue;
    if (secondUnit < 10) {
        secondUnitS = [NSString stringWithFormat:@"0%@",secondUnitS];
    }
    if (minuteUnit < 10) {
        minuteUnitS = [NSString stringWithFormat:@"0%@",minuteUnitS];
    }
    if (hourUnit < 10) {
        hourUnitS = [NSString stringWithFormat:@"0%@",hourUnitS];
    }
    NSString *fullStr = [NSString stringWithFormat:@"%@天%@:%@:%@",dayUnitS,hourUnitS,minuteUnitS,secondUnitS];
    return fullStr;
}


+ (NSString *)stringWithDate:(NSDate *)date format:(NSString *)formatString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
    dateFormatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    dateFormatter.dateFormat = formatString;
    return [dateFormatter stringFromDate:date];
}

+ (NSDate *)dateWithString:(NSString *)string format:(NSString *)formatString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
    dateFormatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    dateFormatter.dateFormat = formatString;
    return [dateFormatter dateFromString:string];
}

+ (NSDate *)localeDateWithUTCDate:(NSDate *)date {

    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date dateByAddingTimeInterval: interval];
    return localeDate;
}


@end

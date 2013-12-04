//
//  DMConsoleHelper.m
//  Perq
//
//  Created by Daniel McCarthy on 12/3/13.
//  Copyright (c) 2013 Daniel McCarthy. All rights reserved.
//

#import "DMConsoleHelper.h"
#import "DMShakyConsoleViewController.h"
#import "asl.h"

@implementation DMConsoleHelper

+ (NSArray *)consoleDataArray
{
    NSMutableArray *consoleLog = [NSMutableArray array];
    
    aslclient       client      = asl_open(NULL, NULL, ASL_OPT_STDERR);
    aslmsg          query       = asl_new(ASL_TYPE_QUERY);
    asl_set_query   (query, ASL_KEY_MSG, NULL, ASL_QUERY_OP_NOT_EQUAL);
    aslresponse     response    = asl_search(client, query);
    asl_free        (query);
    
    aslmsg message;
    while((message = aslresponse_next(response)))
    {
        
        const char  *msg        = asl_get(message, ASL_KEY_MSG);
        const char  *time       = asl_get(message, ASL_KEY_TIME);
        NSString    *timeStr    = [self timeFormatted:[NSString stringWithCString:time encoding:NSUTF8StringEncoding]];
        NSDate      *date       = [self dateFromTime:[NSString stringWithCString:time encoding:NSUTF8StringEncoding]];
        NSString    *detailStr  = [NSString stringWithCString:msg encoding:NSUTF8StringEncoding];
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict   setObject:detailStr forKey:@"message"];
        [dict   setObject:timeStr   forKey:@"time"];
        [dict   setObject:date      forKey:@"date"];
        [consoleLog addObject:dict];
    }
    
    aslresponse_free    (response);
    asl_close           (client);
    
    return consoleLog;
}

+ (NSString *)timeFormatted:(NSString *)totalSeconds
{
    
    double          unixTimeStamp   = [totalSeconds doubleValue];
    NSTimeInterval  _interval       = unixTimeStamp;
    NSDate          *date           = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *_formatter     = [[NSDateFormatter alloc]init];
    [_formatter setLocale:[NSLocale currentLocale]];
    [_formatter setDateFormat:@"dd.MM.yyyy"];
    return [NSString stringWithFormat:@"%@", date];
}

+ (NSDate *)dateFromTime:(NSString *)totalSeconds
{
    
    double          unixTimeStamp   = [totalSeconds doubleValue];
    NSTimeInterval  _interval       = unixTimeStamp;
    NSDate          *date           = [NSDate dateWithTimeIntervalSince1970:_interval];
    return date;
}

- (void)presentConsoleViewController {
    if (_isShakeyViewControllerVisible != YES) {
        _isShakeyViewControllerVisible = YES;
        UIViewController                *rootVC = [[[UIApplication sharedApplication] delegate] window].rootViewController;
        DMShakyConsoleViewController    *vc     = [[DMShakyConsoleViewController alloc] init];
        vc.consoleHelper = self;
        UINavigationController          *navVC  = [[UINavigationController alloc] initWithRootViewController:vc];
        [rootVC presentViewController:navVC animated:YES completion:nil];
    }
}

@end

//
//  DMConsoleHelper.h
//  Perq
//
//  Created by Daniel McCarthy on 12/3/13.
//  Copyright (c) 2013 Daniel McCarthy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMConsoleHelper : NSObject

@property (assign, nonatomic) BOOL isShakeyViewControllerVisible;

+ (NSArray *)consoleDataArray;
+ (NSString *)timeFormatted:(NSString *)totalSeconds;
+ (NSDate *)dateFromTime:(NSString *)totalSeconds;
- (void)presentConsoleViewController;

@end

//
//  DMShakyView.h
//  Perq
//
//  Created by Daniel McCarthy on 12/3/13.
//  Copyright (c) 2013 Daniel McCarthy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMConsoleHelper.h"

@interface DMShakyView : UIView

@property (strong, nonatomic) DMConsoleHelper *consoleHelper;

- (void)enableShakyShaky;

@end

//
//  DMShakyView.m
//  Perq
//
//  Created by Daniel McCarthy on 12/3/13.
//  Copyright (c) 2013 Daniel McCarthy. All rights reserved.
//

#import "DMShakyView.h"

@implementation DMShakyView

- (id)init {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, -1000, 1, 1);
        self.hidden = YES;
        [self registerForNotifications];
        [self becomeFirstResponder];
    }
    return self;
}

- (void)enableShakyShaky {
    /*Check if the application keyWindow contains the shakyView.  Only add
     if it's not already there so we do not keep adding it on every viewDidAppear*/
    if (![[UIApplication sharedApplication].keyWindow.subviews containsObject:self]) {
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    [self becomeFirstResponder];
}

- (void)registerForNotifications {
    /*Need to reassign the shaky view as first responder if a textview etc. has taken over the role*/
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)keyboardDidHide:(NSNotification *)note {
    /*Need to reassign the shaky view as first responder if a textview etc. has taken over the role*/
    [self becomeFirstResponder];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if ( event.subtype == UIEventSubtypeMotionShake )
    {
        if (_consoleHelper == nil)
            _consoleHelper = [[DMConsoleHelper alloc] init];
        [_consoleHelper presentConsoleViewController];
    }
    
    if ( [super respondsToSelector:@selector(motionEnded:withEvent:)] )
        [super motionEnded:motion withEvent:event];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

@end

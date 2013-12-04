//
//  ViewController.m
//  DMShakyConsole
//
//  Created by Daniel McCarthy on 12/4/13.
//  Copyright (c) 2013 Daniel McCarthy. All rights reserved.
//

#import "ViewController.h"
#import "DMShakyView.h"

@interface ViewController ()
/*JUST ADD THE SHAKY VIEW AS A PROPERTY*/
@property (strong, nonatomic) DMShakyView *shakyView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createDummyLogs];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    /*AND ADD THESE 3 LINES IN VIEW DID APPEAR*/
    /*!!!!!!!!!!!!!!REMEMBER TO REMOVE THIS ENTIRE CLASS BEFORE YOU SUBMIT YOUR APP TO THE APP STORE!!!!!!!!!!!!!!!*/
    if (_shakyView == nil)
        _shakyView = [[DMShakyView alloc] init];
    [_shakyView enableShakyShaky];
}

- (void)createDummyLogs {
    NSLog(@"Something strange happened here while I was testing on the go... but now I can just do a little shaky shaky and see what happened!");
    NSLog(@"I got a weird response from the server that caused my app to crash, but now I can just shake and see the server response with the nslog");
    NSLog(@"shake shake shake...  SHAKE SHAKE SHAKE.... Shake your bootay... SHAKE YOUR BOOOOOOTAYY");
    NSLog(@"I'll have a burger, small fry... and a SHAKE!");
    NSLog(@"Do I really need to tell you to shake your money maker?");
    NSLog(@"Error!  Something really silly happened, but didn't crash or create a crash log.  Now I have to go spend 4 hours just trying to reproduce the scenario while wired in, only to find the fix to be changing a single line of code... oh... wait a sec.... I don't need to do that.  I can just SHAKE SHAKE SHAKE and check the log that just happened!");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

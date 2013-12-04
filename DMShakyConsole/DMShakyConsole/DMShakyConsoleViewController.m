//
//  DMShakyConsoleViewController.m
//  Perq
//
//  Created by Daniel McCarthy on 12/3/13.
//  Copyright (c) 2013 Daniel McCarthy. All rights reserved.
//

#import "DMShakyConsoleViewController.h"

@interface DMShakyConsoleViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tblView;
@property (strong, nonatomic) NSMutableArray *consoleArr;

@end

@implementation DMShakyConsoleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"ShakyConsole";
    self.view.backgroundColor                           = [UIColor whiteColor];
    self.navigationItem.hidesBackButton                 = YES;
    self.navigationController.edgesForExtendedLayout    = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = NO;
    
    [self setTheDelegatesAndAllocateTheShizzle];
    [self setLeftNavDoneButton];
    [self setRightNavRefreshButton];
    [self grabTheConsoleData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    _tblView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)setLeftNavDoneButton {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(handleDoneButtonAction:)];
    [self.navigationItem setLeftBarButtonItem:item];
}

- (void)setRightNavRefreshButton {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Refresh" style:UIBarButtonItemStylePlain target:self action:@selector(handleRefreshButtonAction:)];
    [self.navigationItem setRightBarButtonItem:item];
}

- (void)handleDoneButtonAction:(id)sender {
    _consoleHelper.isShakeyViewControllerVisible = NO;
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)handleRefreshButtonAction:(id)sender {
    [self grabTheConsoleData];
}

- (void)setTheDelegatesAndAllocateTheShizzle {
    _tblView            = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:_tblView];
    _tblView.delegate   = self;
    _tblView.dataSource = self;
    _consoleArr         = [NSMutableArray new];
}

- (void)grabTheConsoleData {
    [_consoleArr removeAllObjects];
    NSArray             *consoleDataArr     = [DMConsoleHelper consoleDataArray];
    NSSortDescriptor    *dateDescriptor     = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
    NSArray             *sortDescriptors    = [NSArray arrayWithObject:dateDescriptor];
    NSArray             *sortedArr          = [consoleDataArr sortedArrayUsingDescriptors:sortDescriptors];
    
    [_consoleArr addObjectsFromArray:sortedArr];
    [_tblView reloadData];
}

#pragma mark - TableView Delegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _consoleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_consoleArr.count > 0) {
        NSMutableDictionary *dict       = [NSMutableDictionary dictionaryWithDictionary:[_consoleArr objectAtIndex:indexPath.row]];
        NSString            *message    = [dict objectForKey:@"message"];
        CGSize              maxSize     = CGSizeMake(320, 1000);
        CGSize              cellSize    = [message boundingRectWithSize:maxSize
                                                                options: NSStringDrawingUsesLineFragmentOrigin
                                                             attributes: @{ NSFontAttributeName: [UIFont systemFontOfSize:14.0f] }
                                                                context: nil].size;
        return cellSize.height+70;
    }
    else { return 50.0f; }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *dict;
    if (_consoleArr.count > 0) {
        dict = [NSMutableDictionary dictionaryWithDictionary:[_consoleArr objectAtIndex:indexPath.row]];
    }
    static NSString     *cellIdentifier = @"cellIdentifier";
    UITableViewCell     *cell           = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.textLabel.font                 = [UIFont boldSystemFontOfSize:15.0f];
        cell.textLabel.textColor            = [UIColor blackColor];
        cell.detailTextLabel.font           = [UIFont systemFontOfSize:14.0f];
        cell.detailTextLabel.textColor      = [UIColor darkGrayColor];
        cell.detailTextLabel.numberOfLines  = 0;
    }
    
    cell.textLabel.text         = [dict objectForKey:@"time"];
    cell.detailTextLabel.text   = [dict objectForKey:@"message"];
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

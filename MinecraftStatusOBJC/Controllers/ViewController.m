//
//  ViewController.m
//  MinecraftStatusOBJC
//
//  Created by Turner Eison on 3/29/20.
//  Copyright © 2020 Turner Eison. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, ServerDelegate>

@end

@implementation ViewController

UITableView *tableView;

ServerHandler *handler;

NSNumber *playersOnline;
NSNumber *maxPlayers;
NSString *motd;

// MARK: -View
- (void)viewDidLoad {
    [super viewDidLoad];
    
    playersOnline = [NSNumber numberWithInt:0];
    maxPlayers = [NSNumber numberWithInt:0];
    motd  = @"";
    
    [self.view setBackgroundColor:UIColor.systemBackgroundColor];
    self.title = @"Server Status";
    
    [self makeTableView];
    
    handler = [[ServerHandler alloc] init];
    [handler setHandler:self];
    [handler setAddress: @"https://api.mcsrvstat.us/2/play.turnereison.com"];
    [self refresh];
}

-(void) refresh {
    NSLog(@"refreshing");
    
    playersOnline = [NSNumber numberWithInt:0];
    maxPlayers = [NSNumber numberWithInt:0];
    motd  = @"";
    
    [tableView reloadData];
    [tableView.refreshControl beginRefreshing];
    [handler refreshServer];
}

// MARK: -Server Delegate
- (void)serverReceivedUpdate:(NSDictionary *)object {
    NSLog(@"Got update!!");
    
    motd = object[@"motd"];
    playersOnline = object[@"playersOnline"];
    maxPlayers = object[@"maxPlayers"];
    
    dispatch_async(dispatch_get_main_queue(), ^(void){
        [tableView.refreshControl endRefreshing];
        [tableView reloadData];
        NSLog(@"reloaded");
//        PopupViewController *vc = [[PopupViewController alloc] init];
        PopupViewController *vc = [[PopupViewController alloc] init];
        [self presentViewController:vc animated:YES completion:^{
            NSLog(@"Presented Vc");
        }];
    });
}

// MARK: - UITableView
- (void)makeTableView {
    tableView = [[UITableView alloc] initWithFrame:self.view.frame
                                             style: UITableViewStyleInsetGrouped];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    
    
    tableView.refreshControl = [[UIRefreshControl alloc] init];
    [tableView.refreshControl addTarget:self
                                 action:@selector(refresh)
                       forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:tableView];
}


// MARK: -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch(section) {
        case 0: return @"Refresh";
        case 1: return @"General Info";
        case 2: return @"Advanced Info";
        default: return @"aaaaa";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch(section) {
        case 0: return 1;
        case 1: return 3;
        case 2: return 1;
        default: return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:@"MyCell"];
    }
    
    switch(indexPath.section) {
        case 0:
            cell.textLabel.text = @"play.turnereison.com";
            break;
        case 1:
            switch(indexPath.row) {
                case 0:
                    cell.textLabel.text = @"Address: play.turnereison.com";
                    break;
                case 1:
                    cell.textLabel.text = [NSString stringWithFormat:@"MOTD: %@", motd];
                    break;
                case 2:
                    cell.textLabel.text = [NSString stringWithFormat:@"Online/Max: %@/%@", playersOnline, maxPlayers];
                    break;
            }
            break;
        case 2:
            cell.textLabel.text = @"Advanced";
            break;
    }

    return cell;
}

// MARK: -UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath
                             animated:YES];
}

@end

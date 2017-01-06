//
//  ViewController.m
//  ObjC_test
//
//  Created by Oleg Pavlichenkov on 03/01/2017.
//  Copyright © 2017 Oleg Pavlichenkov. All rights reserved.
//

#import "ViewController.h"
#import "HTTPService.h"
#import "VideoData.h"
#import "VideoCell.h"
#import "ShowVideoVC.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *videoList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorColor = [UIColor clearColor];
    
    self.videoList = [[NSArray alloc] init];
    
    [[HTTPService instance] getTutorials:^(NSArray * _Nullable dataArray, NSString * _Nullable errorMessage) {
        if (dataArray) {
            //NSLog(@"Array: %@", dataArray.debugDescription);
            
            NSMutableArray *arr = [[NSMutableArray alloc]init];
            
            for (NSDictionary *d in dataArray) {
                VideoData *vd = [[VideoData alloc]init];
                vd.videoTitle = [d objectForKey:@"title"];
                vd.videoDescription = [d objectForKey:@"description"];
                vd.videoIframe = [d objectForKey:@"iframe"];
                vd.thumbUrl = [d objectForKey:@"thumbnail"];
                
                [arr addObject:vd];
            }
            
            self.videoList = arr;
            [self updateTableView];
            
        } else if (errorMessage) {
            NSLog(@"%@", errorMessage);
        } else {
            NSLog(@"== UNKNOWN ERROR!!!");
        }
    }];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) updateTableView {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.videoList.count;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    VideoCell *cell = (VideoCell*)[tableView dequeueReusableCellWithIdentifier:@"VideoCell"];
    if (!cell)
        cell = [VideoCell new];
    
    cell.videoData = [self.videoList objectAtIndex:[indexPath row]];
    [cell updateUI];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // all made at cellForRowAtIndexPath
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    VideoCell *cell = (VideoCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (cell) {
        [self performSegueWithIdentifier:@"ShowVideoVC" sender:cell.videoData];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ShowVideoVC"]) {
        
        ShowVideoVC *vc = [segue destinationViewController];
        vc.videoData = (VideoData*)sender;

    }
}

@end

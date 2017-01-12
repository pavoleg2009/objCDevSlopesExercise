//
//  ShowVideoVC.m
//  ObjC_test
//
//  Created by Oleg Pavlichenkov on 03/01/2017.
//  Copyright © 2017 Oleg Pavlichenkov. All rights reserved.
//

#import "ShowVideoVC.h"
#import "VideoData.h"
#import "CommentData.h"
#import "CommentCell.h"
#import "HTTPService.h"

@interface ShowVideoVC ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *commentTextField;
@property (weak, nonatomic) IBOutlet UIButton *postButton;

@property (nonatomic, strong) NSMutableArray *commentList;
@property (weak, nonatomic) IBOutlet UILabel *commentContentLabel;

@end

@implementation ShowVideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.webView.delegate = self;
    
    [self updateUI];
}


- (void) updateUI {
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    if (self.videoData) {
        self.titleLabel.text = self.videoData.videoTitle;
        self.descriptionLabel.text = self.videoData.videoDescription;
    // TODO: Uncomment to load video
//        [self.webView loadHTMLString:self.videoData.videoIframe baseURL:nil];
        
//        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.videoData.thumbUrl]]];
//        self.thumbImage.image = image;
        
        [self readComments];
    }
    
}

-(void) readComments {
    [[HTTPService instance] getCommentsForTutorialWith: self.videoData.videoId :^(NSArray * _Nullable dataArray, NSString * _Nullable errorMessage) {
        if (dataArray) {

            NSMutableArray *arr = [[NSMutableArray alloc]init];
            
            for (NSDictionary *d in dataArray) {
                NSLog(@"== Parsing JSON with comments");
                NSLog(@"%@", dataArray);
                CommentData *cd = [[CommentData alloc]init];
                cd.commentId = [d objectForKey:@"_id"];
                cd.commentContent = [d objectForKey:@"content"];

                [arr addObject: cd];
            }
            
            self.commentList = arr;
            [self updateTableView];
            
        } else if (errorMessage) {
            NSLog(@"%@", errorMessage);
        } else {
            NSLog(@"== UNKNOWN ERROR!!!");
        }
    }];

}

- (void) updateTableView {
    // TODO: update tableView
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (IBAction)backButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    // inserting CSS with JS to modify webView
    NSString *css = @".container {position: relative; width: 100%; height: 0; padding-bottom: 56.25%; } .video {position: absolute; top: 0; left: 0; width: 100%; height: 100%; }";
    NSString* js = [NSString stringWithFormat:
                    @"var styleNode = document.createElement('style');\n"
                    "styleNode.type = \"text/css\";\n"
                    "var styleText = document.createTextNode('%@');\n"
                    "styleNode.appendChild(styleText);\n"
                    "document.getElementsByTagName('head')[0].appendChild(styleNode);\n",css];
    NSLog(@"js:\n%@",js);
    [self.webView stringByEvaluatingJavaScriptFromString:js];
}


- (IBAction)postButtonTapped:(id)sender {

    [self createComment];
}

- (void) createComment {

    if (self.commentTextField.text && ![self.commentTextField.text  isEqual: @""]) {
        
        // TODO: replace @"pavoleg" with the curren user name
        NSDictionary *comment = @{
                                  //@"tutorial_id":self.videoData.videoId, // send tutorial Id in adress, not in body
                                  @"author":@"pavoleg",
                                  @"content": self.commentTextField.text
                                  };
        
        NSError *error;
        
        NSURLSession *session = [NSURLSession sharedSession];
        // TODO : replace hard-coded DB server adress to adjusable params
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:6069/tutorials/%@/comments", self.videoData.videoId]];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request addValue:@"application/json" forHTTPHeaderField:@"content-type"];
        [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setHTTPMethod:@"POST"];
        
        NSData *postData = [NSJSONSerialization dataWithJSONObject:comment options:0 error:&error];
        
        [request setHTTPBody:postData];
        
        NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            // handle error here
        }];
        
        [postDataTask resume];
        
        
        [self finishCommentCreating];
    }
}

- (void)finishCommentCreating {
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.commentList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    CommentCell *cell = (CommentCell*)[tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
    if (!cell)
        cell = [CommentCell new];
    
    cell.commentData = [self.commentList objectAtIndex:[indexPath row]];
    [cell updateUI];
    
    return cell;
}

@end

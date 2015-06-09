//
//  MainTableViewController.m
//  BPUT App
//
//  Created by Shantanu Paul on 02/06/15.
//  Copyright (c) 2015 Shantanu Paul. All rights reserved.
//

#import "MainTableViewController.h"
#import "ParseOperation.h"

@interface MainTableViewController ()

@property (nonatomic,strong) Notice* notice;

@end

@implementation MainTableViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    static NSString* mainURLString = @"http://paul-shantanu-bputapp.appspot.com/default.php";
    NSURLRequest* noticeListRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:mainURLString]];
    [NSURLConnection sendAsynchronousRequest:noticeListRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse* response,NSData* data, NSError* connectionError){
        if(connectionError != nil)
        {
        }
        else
        {
            
           //NSLog([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            
                ParseOperation* parseOperation = [[ParseOperation alloc]initWithData:data instance:self];
                [parseOperation startParsing];
            
            
        }
        
    }
    
     ];}


-(void)generateList:(Notice*)notice
{
    self.notice = notice;
    [self.tableView reloadData];
    NSLog(@"Reload Data OK");
    
}



#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.notice.notice_head count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Notice Item" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.notice.notice_head objectAtIndex:indexPath.row];
    

    
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

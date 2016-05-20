//
//  MainTableViewController.m
//  BPUT App
//
//  Created by Shantanu Paul on 02/06/15.
//  Copyright (c) 2015 Shantanu Paul. All rights reserved.
//

#import "MainTableViewController.h"
#import "ParseOperation.h"
#import "URLDecoder.h"
#import "HTMLNoticeViewController.h"
#import "PDFNoticeViewController.h"

@interface MainTableViewController ()

@property (nonatomic,strong) Notice* notice;
@property (nonatomic,strong) NSString* urlToSegue;

@end

@implementation MainTableViewController




-(void)viewDidLoad {
    [super viewDidLoad];
    
    static NSString* mainURLString = @"https://paul-shantanu-bputapp.appspot.com/default.php";
    NSURLRequest* noticeListRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:mainURLString]];
    NSURLSession *session = [NSURLSession sharedSession];
    [session dataTaskWithRequest:noticeListRequest completionHandler:^(NSData *data,NSURLResponse *response, NSError *connectionError){
        if(connectionError != nil)
        {
            NSLog(@"no data received");
        }
        else
        {
                ParseOperation* parseOperation = [[ParseOperation alloc]initWithData:data instance:self];
                [parseOperation startParsing];
        }
        
    }];
}


-(void)generateListWithObject:(Notice *)notice
{
    self.notice = notice;
    [self.tableView reloadData];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    URLDecoder* urlDecoder = [[URLDecoder alloc]init];
    NSString* decodedUrl = [urlDecoder getDecodedURL:[self.notice.url objectAtIndex:indexPath.row]];
    self.urlToSegue = decodedUrl;
    
  //  NSLog(decodedUrl);
    
    if([urlDecoder getUrlType:decodedUrl] == urlDecoder.HTML_FILE)
    {
    
        [self performSegueWithIdentifier:@"HTML Notice Segue" sender:self];
        
    }
    else if([urlDecoder getUrlType:decodedUrl] == urlDecoder.PDF_FILE)
    {
        
        [self performSegueWithIdentifier:@"PDF Notice Segue" sender:self];

    }
    else
    {
        NSLog(@"Error in determing URL type");
    }
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





#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"HTML Notice Segue"])
    {
        HTMLNoticeViewController* htmlNoticeViewController = (HTMLNoticeViewController*)segue.destinationViewController;
        htmlNoticeViewController.url = self.urlToSegue;
    }
    
    if ([segue.identifier isEqualToString:@"PDF Notice Segue"]) {
        PDFNoticeViewController* pdfNoticeViewController = (PDFNoticeViewController*)segue.destinationViewController;
        pdfNoticeViewController.url = self.urlToSegue;
    }
}


@end

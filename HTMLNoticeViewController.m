//
//  HTMLNoticeViewController.m
//  BPUT App
//
//  Created by Shantanu Paul on 02/06/15.
//  Copyright (c) 2015 Shantanu Paul. All rights reserved.
//

#import "HTMLNoticeViewController.h"
#import "ParseOperation.h"

@interface HTMLNoticeViewController ()

@property (weak, nonatomic) IBOutlet UITextView *noticeTextView;

@end

@implementation HTMLNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString* mainURLString = self.url;
    
    NSString* dataToPost = [@"url=" stringByAppendingString: mainURLString];
    
    NSMutableURLRequest* noticeRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://paul-shantanu-bputapp.appspot.com/notice.php"]];
    [noticeRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [noticeRequest setHTTPMethod:@"POST"];
    [noticeRequest setHTTPBody:[NSData dataWithBytes:[dataToPost UTF8String] length:strlen([dataToPost UTF8String])]];
    [NSURLConnection sendAsynchronousRequest:noticeRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse* response,NSData* data, NSError* connectionError){
        if(connectionError != nil)
        {
        }
        else
        {
            NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            
            ParseOperation* parseOperation = [[ParseOperation alloc]initWithData:data instance:self];
            [parseOperation startParsing];
        }
    }];
}

-(void)displayNoticeWithObject:(Notice*)notice
{
    NSLog(@"%@",[notice getNoticeBody]);
    self.noticeTextView.text = [[notice getNoticeBody]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

}


@end

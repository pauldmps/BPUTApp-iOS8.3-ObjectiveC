//
//  PDFNoticeViewController.m
//  BPUT App
//
//  Created by Shantanu Paul on 07/06/15.
//  Copyright (c) 2015 Shantanu Paul. All rights reserved.
//

#import "PDFNoticeViewController.h"
#import "PlugPDF/DocumentView.h"
#import "PlugPDF/Document.h"


@interface PDFNoticeViewController ()

@property (nonatomic,strong)PlugPDFDocumentView *documentView;

@end

@implementation PDFNoticeViewController

- (IBAction)previousPage:(UIBarButtonItem *)sender {
    
    if(!([self.documentView pageIdx]==0))
        [self.documentView gotoPage:self.documentView.pageIdx-1 fitToScreen:YES];
}


- (IBAction)nextPage:(UIBarButtonItem *)sender {
    
    if(!([self.documentView pageIdx]== [self.documentView.document pageCount]-1))
        [self.documentView gotoPage:self.documentView.pageIdx+1 fitToScreen:YES];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
        if(!connectionError)
        {
        
            NSString *docsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
            NSString *filePath = [[NSString alloc] initWithString: [docsPath stringByAppendingPathComponent:@"notice.pdf"]];
            [data writeToFile:filePath atomically:YES];
            
            
            CGRect rect = CGRectMake(0.0, 65.0,self.view.frame.size.width,self.view.frame.size.height - 130.0);
            
            @try {
                self.documentView = [PlugPDFDocumentView initWithFrame:rect path:filePath password:nil];
            }
            @catch (NSException *exception) {
                NSLog(@"Exception %@ %@", exception.name, exception.description);
            }
            
            if (self.documentView) {
                CGRect content = CGRectMake(0.0, 0.0,self.view.frame.size.width,self.view.frame.size.height - 130.0);
                
                [self.documentView setContentWithFrame: content];
                [self.documentView gotoPage: 0 fitToScreen: YES];
                [self.documentView setDocumentViewEventDelegate: self];
                
                [self.view addSubview: self.documentView];

                if ([[UIDevice currentDevice].systemVersion hasPrefix:@"7"] ||[[UIDevice currentDevice].systemVersion hasPrefix:@"8"]) {
                    [self setAutomaticallyAdjustsScrollViewInsets: NO];
                }
            }
        }
    }];

    
    
}

#pragma mark - PlugPDFDocumentViewEventDelegate

- (BOOL)pageWillChange:(PlugPDFDocumentView *)documentView
               pageIdx:(NSInteger)pageIdx
{
    return NO;
}



@end

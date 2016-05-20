//
//  URLDecoder.m
//  BPUT App
//
//  Created by Shantanu Paul on 10/06/15.
//  Copyright (c) 2015 Shantanu Paul. All rights reserved.
//

#import "URLDecoder.h"

@interface URLDecoder ()

@property (readwrite,nonatomic)NSInteger HTML_FILE;
@property (readwrite,nonatomic)NSInteger PDF_FILE;
@property (nonatomic,strong)NSMutableString* url;

@end

@implementation URLDecoder

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.HTML_FILE = 0;
        self.PDF_FILE = 1;
    }
    return self;
}

-(NSString *)getDecodedURL:(NSString *)urlToDecode
{
    self.url = [[NSMutableString alloc]init];
    NSLog(@"getDecodedURL is called");

    urlToDecode = [[urlToDecode stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    
    if([urlToDecode hasPrefix:@"javascript"])
    {
        NSArray *components = [urlToDecode componentsSeparatedByString:@"'"];
        if (components.count > 1)
        {
            NSString *substring = components[1];
            urlToDecode = substring;

        }
        
        NSLog(@"hasPrefix javascript is true");
        NSLog(@"%@",urlToDecode);
        
         
    }
    else
    {
        [self.url appendString:urlToDecode];
        NSLog(@"hasPrefix javascript is false");
    }
         
    if(![self.url hasPrefix:@"http"])
    {
        [self.url deleteCharactersInRange:NSMakeRange(0, [self.url length])];
        [self.url appendString:@"http://www.bput.ac.in/"];
        [self.url appendString:urlToDecode];
    }
    
    NSLog(@"%@",self.url);
    
    return self.url;
}


-(NSInteger)getUrlType:(NSString *)url
{
    if([url hasSuffix:@"pdf"])
    {
    return self.PDF_FILE;
    }
    
    else return self.HTML_FILE;
}

    
     
     
@end


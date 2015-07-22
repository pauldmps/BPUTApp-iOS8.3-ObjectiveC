//
//  URLDecoder.h
//  BPUT App
//
//  Created by Shantanu Paul on 10/06/15.
//  Copyright (c) 2015 Shantanu Paul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLDecoder : NSObject

@property (readonly,nonatomic)NSInteger HTML_FILE;
@property (readonly,nonatomic)NSInteger PDF_FILE;

-(NSString*)getDecodedURL:(NSString*)urlToDecode;
-(NSInteger)getUrlType:(NSString*)url;

@end

//
//  ParseOperation.h
//  BPUT App
//
//  Created by Shantanu Paul on 07/06/15.
//  Copyright (c) 2015 Shantanu Paul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Notice.h"
#import "MainTableViewController.h"


@interface ParseOperation : NSObject

@property (readonly, nonatomic, strong) Notice* notice;


-(instancetype)initWithData:(NSData*)data instance:(MainTableViewController*)instance;
-(void)startParsing;


@end

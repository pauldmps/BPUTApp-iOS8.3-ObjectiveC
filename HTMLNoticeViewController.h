//
//  HTMLNoticeViewController.h
//  BPUT App
//
//  Created by Shantanu Paul on 02/06/15.
//  Copyright (c) 2015 Shantanu Paul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Notice.h"



@interface HTMLNoticeViewController : UIViewController

@property (nonatomic,strong)NSString* url;

-(void)displayNoticeWithObject:(Notice*)notice;

@end

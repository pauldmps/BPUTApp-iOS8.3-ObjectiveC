//
//  PDFNoticeViewController.h
//  BPUT App
//
//  Created by Shantanu Paul on 07/06/15.
//  Copyright (c) 2015 Shantanu Paul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlugPDF/DocumentViewEventDelegate.h"

@interface PDFNoticeViewController : UIViewController <PlugPDFDocumentViewEventDelegate>

@property (nonatomic,strong)NSString* url;

@end

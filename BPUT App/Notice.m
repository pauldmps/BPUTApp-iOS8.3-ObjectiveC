//
//  Notice.m
//  BPUT App
//
//  Created by Shantanu Paul on 08/06/15.
//  Copyright (c) 2015 Shantanu Paul. All rights reserved.
//

#import "Notice.h"


@implementation Notice


-(instancetype)init
{
    self = [super init];
    if(self !=nil)
    {
        self.url = [[NSMutableArray alloc]init];
        self.notice_head= [[NSMutableArray alloc]init];
        self.notice_body= [[NSMutableString alloc]init];
        self.table_head= [[NSMutableArray alloc]init];
        self.table_body= [[NSMutableArray alloc]init];
        self.has_table=false;
    
        return self;
    
    }
    return nil;
}

-(void)insertUrl:(NSString *)url atPosition:(NSUInteger)pos
{
    [self.url insertObject:url atIndex:pos];
}

-(void)insertNoticeHead:(NSString *)notice_head atPosition:(NSUInteger)pos
{
    [self.notice_head insertObject:notice_head atIndex:pos];
}

-(void)addNoticeBody:(NSString *)notice_body
{
    [self.notice_body appendString:[notice_body stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"]];
}

-(void)addTableHead:(NSString *)table_head
{
    [self.table_head addObject:table_head];
}

-(void)addTableBody:(NSString *)table_body
{
    [self.table_body addObject:table_body];
}



@end

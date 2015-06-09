//
//  Notice.h
//  BPUT App
//
//  Created by Shantanu Paul on 08/06/15.
//  Copyright (c) 2015 Shantanu Paul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Notice : NSObject

@property (nonatomic,strong, getter=getUrl) NSMutableArray* url;
@property (nonatomic,strong, getter=getNoticeHead) NSMutableArray* notice_head;
@property (nonatomic,strong, getter=getTableHead) NSMutableArray* table_head;
@property (nonatomic,strong,getter=getTableBody) NSMutableArray* table_body;
@property (nonatomic,strong,getter=getNoticeBody) NSMutableString* notice_body;
@property (nonatomic,getter=hasTable) BOOL has_table;



-(void)insertUrl:(NSString *)url atPosition:(NSUInteger)pos;
-(void)insertNoticeHead:(NSString *)notice_head atPosition:(NSUInteger)pos;
-(void)addNoticeBody:(NSString *)notice_body;
-(void)addTableHead:(NSString *)table_head;
-(void)addTableBody:(NSString *)table_body;

-(instancetype)init;

@end

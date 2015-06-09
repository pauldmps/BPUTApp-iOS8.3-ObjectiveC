//
//  ParseOperation.m
//  BPUT App
//
//  Created by Shantanu Paul on 07/06/15.
//  Copyright (c) 2015 Shantanu Paul. All rights reserved.
//

#import "ParseOperation.h"

@interface ParseOperation() <NSXMLParserDelegate>

@property (readwrite,nonatomic,strong) Notice* notice;
@property (copy) NSData* dataToParse;
@property (nonatomic,strong)MainTableViewController* mainTableViewControllerInstance;


@end


@implementation ParseOperation


NSUInteger i =0;
NSMutableString* tempString;


-(instancetype)initWithData:(NSData*)data instance:(MainTableViewController*)instance //constructor
{
    self = [super init];
    if(self != nil)
    {
        self.dataToParse = [data copy];
        self.mainTableViewControllerInstance = instance;
    }
    return self;
}

-(void)startParsing
{
    
    NSXMLParser* parser = [[NSXMLParser alloc]initWithData:self.dataToParse];
    [parser setDelegate:self];
    [parser parse];
    
}



-(void)parserDidStartDocument:(NSXMLParser *)parser
{
  self.notice = [[Notice alloc]init];
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"notice"] ) {
        [self.notice insertUrl:[attributeDict valueForKey:@"url"] atPosition:i];
    }
    
    if ([elementName isEqualToString:@"thead"] ) {
        
        [self.notice setHas_table:true];
    }

}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    
    tempString = [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]mutableCopy];
    
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
     if ([elementName isEqualToString:@"notice"] ) {
         [self.notice insertNoticeHead:tempString atPosition:i];
         i++;
     }
     else if ([elementName isEqualToString:@"text"]) {
         [self.notice addNoticeBody:tempString];
     }
     else if ([elementName isEqualToString:@"thead"]){
         [self.notice addTableHead:tempString];
     }
     else if ([elementName isEqualToString:@"td"]){
         [self.notice addTableBody:tempString];
     }
}

-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    [self.mainTableViewControllerInstance performSelector:@selector(generateList:) withObject:self.notice];
}

@end

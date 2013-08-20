//
//  ttTestEntity.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/14/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import "ttTestEntity.h"

@implementation ttTestEntity

-(id) init
{
    self = [super init];
    if (self)
    {
        _groupId = -1;
        _itemId = -1;
        _filterValues = [[NSMutableArray alloc]init];
        _date = [NSDate dateWithTimeIntervalSince1970:0];
    }
    return self;
}

#pragma -mark ttXmlParserDelegate functions

-(void) finishedChild:(NSString*)s;
{
    // we finished parsing the child elements so store the values
    if ([self.child.name isEqualToString:@"value"])
    {
        self.entityString = s;
    }
    else if ([self.child.name isEqualToString:@"filter"])
    {
        [self.filterValues addObject:s];
    }
    //self.child = nil;
}

-(void)parseElementAttributes:(NSDictionary *)attributeDictionary
{
    NSNumber *groupId = [attributeDictionary objectForKey:@"groupId"];
    NSNumber *itemId = [attributeDictionary objectForKey:@"itemId"];
    NSDate *date = [attributeDictionary objectForKey:@"date"];
    _itemId = itemId.intValue;
    _groupId = groupId.intValue;
    _date = date;
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    // we are expecting child elements for value and filters so
    // create a generic parser for the item and make it the delegate
    ttXmlParserDelegate *parserItem = [[ttXmlParserDelegate alloc]init];
    [parserItem startElementNamed:elementName withParentParser:self];
    self.child = parserItem;
    parser.delegate = parserItem;
}

@end

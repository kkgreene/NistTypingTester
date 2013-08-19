//
//  ttTestPhrase.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/14/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import "ttProficiencyItem.h"

@implementation ttProficiencyItem

-(id) init
{
    self = [super init];
    if (self)
    {
        _groupId = -1;
        _itemId = -1;
    }
    return self;
}

#pragma -mark ttXmlParserDelegate functions

-(void)parseElementAttributes:(NSDictionary *)attributeDictionary
{
    NSNumber *groupId = [attributeDictionary objectForKey:@"groupId"];
    NSNumber *itemId = [attributeDictionary objectForKey:@"itemId"];
    _itemId = itemId.intValue;
    _groupId = groupId.intValue;
}


-(void) finishedChild:(NSString*)s;
{
    self.child = nil;
}


@end

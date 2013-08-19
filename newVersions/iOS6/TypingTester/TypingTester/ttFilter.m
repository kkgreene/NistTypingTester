//
//  ttFilter.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/19/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import "ttFilter.h"

@implementation ttFilter

-(id) init
{
    self = [super init];
    if (self)
    {
    
    }
    return self;
}

-(void)parseElementAttributes:(NSDictionary *)attributeDictionary
{
    self.filterId = [attributeDictionary objectForKey:@"filterId"];
}


@end

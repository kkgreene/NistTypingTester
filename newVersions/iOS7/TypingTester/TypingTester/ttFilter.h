//
//  ttFilter.h
//  TypingTester
//
//  Created by Matthew Kerr on 8/19/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import "ttXmlParserDelegate.h"

@interface ttFilter : ttXmlParserDelegate

@property (nonatomic, copy) NSString *filterId;
@property (nonatomic, assign) BOOL selected;

@end

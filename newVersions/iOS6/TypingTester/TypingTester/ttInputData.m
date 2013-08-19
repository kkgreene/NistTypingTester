//
//  ttInputData.m
//  TypingTester
//
//  Created by Matthew Kerr on 8/19/13.
//  Copyright (c) 2013 Matthew Kerr. All rights reserved.
//

#import "ttInputData.h"
#import "ttUtilities.h"
#import "ttFilter.h"
#import "ttProficiencyItem.h"
#import "ttTestEntity.h"

@implementation ttInputData

static ttInputData *instance = nil;

+(ttInputData*) Instance
{
    static dispatch_once_t _singletonPredicate;
    
    dispatch_once(&_singletonPredicate, ^{ instance = [[self alloc] init];});
    
    return instance;
}

-(id)init
{
    self = [super init];
    if(self)
    {
        _entities = [[NSMutableArray alloc]init];
        _testPhrases = [[NSMutableArray alloc]init];
        _filters = [[NSMutableArray alloc]init];
    }
    return self;
}

-(void)loadDataFile:(NSString *)filepath
{
    NSString* documentsDirectory = [ttUtilities documentsDirectory];
    NSString *inputFile = [documentsDirectory stringByAppendingPathComponent:@"inputStrings.xml"];
    NSURL *url = [NSURL fileURLWithPath:inputFile];
    NSXMLParser *parser = [[NSXMLParser alloc]initWithContentsOfURL:url];
    parser.delegate = self;
    [parser parse];
}

#pragma -mark NSXMLParserDelegate functions
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"filterItem"])
    {
        ttFilter *newFilter = [[ttFilter alloc]init];
        [self.filters addObject:newFilter];
        [newFilter parseElementAttributes:attributeDict];
        [newFilter startElementNamed:elementName withParentParser:self];
        parser.delegate = newFilter;
    }
    else if ([elementName isEqualToString:@"proficiencyInput"])
    {

    }
    else if ([elementName isEqualToString:@"memorizationInput"])
    {
        
    }
}

@end

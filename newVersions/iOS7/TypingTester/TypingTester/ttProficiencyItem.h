//
//  ttTestPhrase.h
//  TypingTester
//
//  Created by Matthew Kerr on 8/14/13.
//

#import <Foundation/Foundation.h>
#import "ttXmlParserDelegate.h"

@interface ttProficiencyItem : ttXmlParserDelegate

@property (nonatomic, assign) int groupId;
@property (nonatomic, assign) int itemId;


@end

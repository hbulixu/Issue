//
//  NSMutableStringExtensions.m
//  DC
//
//  Created by 최건우 on 11. 2. 2..
//  Copyright 2011 Unplug. All rights reserved.
//

#import "NSMutableStringExtensions.h"


@implementation NSMutableString (NSMutableStringExtensions)
- (void)xmlSimpleUnescape{
    [self replaceOccurrencesOfString:@"&amp;"	withString:@"&"		options:NSLiteralSearch range:NSMakeRange(0, [self length])];
    [self replaceOccurrencesOfString:@"&quot;"	withString:@"\""	options:NSLiteralSearch range:NSMakeRange(0, [self length])];
    [self replaceOccurrencesOfString:@"&#x27;"	withString:@"'"		options:NSLiteralSearch range:NSMakeRange(0, [self length])];
    [self replaceOccurrencesOfString:@"&#x39;"	withString:@"'"		options:NSLiteralSearch range:NSMakeRange(0, [self length])];
    [self replaceOccurrencesOfString:@"&#x92;"	withString:@"'"		options:NSLiteralSearch range:NSMakeRange(0, [self length])];
    [self replaceOccurrencesOfString:@"&#x96;"	withString:@"'"		options:NSLiteralSearch range:NSMakeRange(0, [self length])];
    [self replaceOccurrencesOfString:@"&gt;"	withString:@">"		options:NSLiteralSearch range:NSMakeRange(0, [self length])];
    [self replaceOccurrencesOfString:@"&lt;"	withString:@"<"		options:NSLiteralSearch range:NSMakeRange(0, [self length])];
	[self replaceOccurrencesOfString:@"&nbsp;"	withString:@" "		options:NSLiteralSearch range:NSMakeRange(0, [self length])];
}

- (void)xmlSimpleEscape{
    [self replaceOccurrencesOfString:@"&"	withString:@"&amp;"		options:NSLiteralSearch range:NSMakeRange(0, [self length])];
    [self replaceOccurrencesOfString:@"\""	withString:@"&quot;"	options:NSLiteralSearch range:NSMakeRange(0, [self length])];
    [self replaceOccurrencesOfString:@"'"	withString:@"&#x27;"	options:NSLiteralSearch range:NSMakeRange(0, [self length])];
    [self replaceOccurrencesOfString:@">"	withString:@"&gt;"		options:NSLiteralSearch range:NSMakeRange(0, [self length])];
    [self replaceOccurrencesOfString:@"<"	withString:@"&lt;"		options:NSLiteralSearch range:NSMakeRange(0, [self length])];
	[self replaceOccurrencesOfString:@" "	withString:@"&nbsp;"	options:NSLiteralSearch range:NSMakeRange(0, [self length])];
}
@end

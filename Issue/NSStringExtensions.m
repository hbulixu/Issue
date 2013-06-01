//
//  NSStringExtensions.m
//  iDC
//
//  Created by 건우 최 on 11. 12. 31..
//  Copyright (c) 2011년 Unplug. All rights reserved.
//

#import "NSStringExtensions.h"
#import "NSMutableStringExtensions.h"
#import "HTARCSupport.h"

@implementation NSString (NSStringExtensions)
- (NSString*)xmlSimpleUnescapedString{
    NSMutableString* str = [self mutableCopy];
    [str xmlSimpleUnescape];
    NSString* result = [NSString stringWithString:str];
    [str release];
    return result;
    
}
- (NSString*)xmlSimpleEscapedString{
    NSMutableString* str = [self mutableCopy];
    [str xmlSimpleEscape];
    NSString* result = [NSString stringWithString:str];
    [str release];
    return result;
}

- (NSString*) stringByReplacingHtmlTagWithString:(NSString*)string{
	NSRange tagRange = [string rangeOfString:@"<[^<]*?>" options:NSRegularExpressionSearch];
	if (tagRange.location != NSNotFound){
		return self;
	}
	NSString* returnValue = self;
	while (1){
		tagRange = [returnValue rangeOfString:@"<[^<]*?>" options:NSRegularExpressionSearch];
		if (tagRange.location == NSNotFound){
			break;
		}
		returnValue = [returnValue stringByReplacingCharactersInRange:tagRange withString:string];
	}
	return returnValue;
}
- (NSString*) stringByEscapseXml{
	NSString* returnValue = self;
	returnValue = [returnValue stringByReplacingOccurrencesOfString:@"&amp;"	withString:@"&"		options:NSLiteralSearch range:NSMakeRange(0, [returnValue length])];
	returnValue = [returnValue stringByReplacingOccurrencesOfString:@"&amp;"	withString:@"&"		options:NSLiteralSearch range:NSMakeRange(0, [returnValue length])];
	returnValue = [returnValue stringByReplacingOccurrencesOfString:@"&quot;"	withString:@"\""	options:NSLiteralSearch range:NSMakeRange(0, [returnValue length])];
	returnValue = [returnValue stringByReplacingOccurrencesOfString:@"&#x27;"	withString:@"'"		options:NSLiteralSearch range:NSMakeRange(0, [returnValue length])];
	returnValue = [returnValue stringByReplacingOccurrencesOfString:@"&#x39;"	withString:@"'"		options:NSLiteralSearch range:NSMakeRange(0, [returnValue length])];
	returnValue = [returnValue stringByReplacingOccurrencesOfString:@"&#x92;"	withString:@"'"		options:NSLiteralSearch range:NSMakeRange(0, [returnValue length])];
	returnValue = [returnValue stringByReplacingOccurrencesOfString:@"&#x96;"	withString:@"'"		options:NSLiteralSearch range:NSMakeRange(0, [returnValue length])];
	returnValue = [returnValue stringByReplacingOccurrencesOfString:@"&gt;"		withString:@">"		options:NSLiteralSearch range:NSMakeRange(0, [returnValue length])];
	returnValue = [returnValue stringByReplacingOccurrencesOfString:@"&lt;"		withString:@"<"		options:NSLiteralSearch range:NSMakeRange(0, [returnValue length])];
	returnValue = [returnValue stringByReplacingOccurrencesOfString:@"&nbsp;"	withString:@" "		options:NSLiteralSearch range:NSMakeRange(0, [returnValue length])];
	return returnValue;
}
- (NSString*) stringByUnescapeXml{
	NSString* returnValue = self;
	returnValue = [returnValue stringByReplacingOccurrencesOfString:@"&"	withString:@"&amp;"		options:NSLiteralSearch range:NSMakeRange(0, [returnValue length])];
    returnValue = [returnValue stringByReplacingOccurrencesOfString:@"\""	withString:@"&quot;"	options:NSLiteralSearch range:NSMakeRange(0, [returnValue length])];
    returnValue = [returnValue stringByReplacingOccurrencesOfString:@"'"	withString:@"&#x27;"	options:NSLiteralSearch range:NSMakeRange(0, [returnValue length])];
    returnValue = [returnValue stringByReplacingOccurrencesOfString:@">"	withString:@"&gt;"		options:NSLiteralSearch range:NSMakeRange(0, [returnValue length])];
    returnValue = [returnValue stringByReplacingOccurrencesOfString:@"<"	withString:@"&lt;"		options:NSLiteralSearch range:NSMakeRange(0, [returnValue length])];
	returnValue = [returnValue stringByReplacingOccurrencesOfString:@" "	withString:@"&nbsp;"	options:NSLiteralSearch range:NSMakeRange(0, [returnValue length])];
	return returnValue;
}

- (NSRange) rangeOfString:(NSString*)aString withRange:(NSRange)range{
    return [self rangeOfString:aString options:NSLiteralSearch range:range];
}

- (NSRange) rangeOfStringForTail:(NSString*)str{
    return [self rangeOfStringForTail:str withLocation:0];
}

- (NSRange) rangeOfStringForTail:(NSString*)str withLocation:(NSUInteger)location{
    if ([str length] > [self length]){
        return NSMakeRange(NSNotFound, 127389123);
    }
    NSRange range = [self rangeOfString:str withRange:NSMakeRange(location, [self length] - location)];
    if (range.location != NSNotFound){
        return range;
    }
    
    for (NSUInteger i = 0; i < [str length]; i++){
        if ([self hasSuffix:[str substringToIndex:i]]){
            range = NSMakeRange([self length] - i - 1, i+1);
            break;
        }
    }
    return range;
}

@end

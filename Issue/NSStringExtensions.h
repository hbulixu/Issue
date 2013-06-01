//
//  NSStringExtensions.h
//  iDC
//
//  Created by 건우 최 on 11. 12. 31..
//  Copyright (c) 2011년 Unplug. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NSStringExtensions)

- (NSString*)xmlSimpleUnescapedString;
- (NSString*)xmlSimpleEscapedString;
- (NSString*) stringByReplacingHtmlTagWithString:(NSString*)string;
- (NSString*) stringByEscapseXml;
- (NSString*) stringByUnescapeXml;
- (NSRange) rangeOfString:(NSString*)aString withRange:(NSRange)range;
- (NSRange) rangeOfStringForTail:(NSString*)str;
- (NSRange) rangeOfStringForTail:(NSString*)str withLocation:(NSUInteger)location;

@end

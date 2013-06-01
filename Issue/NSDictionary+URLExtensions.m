//
//  NSDictionary+URLExtensions.m
//  iDC
//
//  Created by 건우 최 on 11. 12. 31..
//  Copyright (c) 2011년 Unplug. All rights reserved.
//

#import "NSDictionary+URLExtensions.h"
#import "NSString+URLAddition.h"

@implementation NSDictionary (URLExtensions)
- (NSString*)urlEncodeWithEncoding:(NSStringEncoding)encoding{
    NSMutableArray* nameValuePairs = [NSMutableArray array];
    for (NSString* name in self.allKeys){
        NSString* value = [NSString stringWithFormat:@"%@", [self objectForKey:name]];
        NSString* nameValuePair = [NSString stringWithFormat:@"%@=%@",
                                   [name URLEncodedStringWithEncoding:encoding],
                                   [value URLEncodedStringWithEncoding:encoding]];
        [nameValuePairs addObject:nameValuePair];
    }
    return [nameValuePairs componentsJoinedByString:@"&"];
}

- (NSString*)sortedURLEncodeWithEncoding:(NSStringEncoding)encoding{
    NSMutableArray* nameValuePairs = [NSMutableArray array];
    for (NSString* name in [self.allKeys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]){
        NSString* value = [NSString stringWithFormat:@"%@", [self objectForKey:name]];
        NSString* nameValuePair = [NSString stringWithFormat:@"%@=%@",
                                   [name URLEncodedStringWithEncoding:encoding],
                                   [value URLEncodedStringWithEncoding:encoding]];
        [nameValuePairs addObject:nameValuePair];
    }
    return [nameValuePairs componentsJoinedByString:@"&"];
}

@end

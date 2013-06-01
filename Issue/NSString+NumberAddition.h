//
//  NSString+NumberAddition.h
//  YoureMyPet
//
//  Created by 건우 최 on 12. 1. 12..
//  Copyright (c) 2012년 Unplug. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NumberAddition)
+ (NSString*)stringWithInt:(int)val;
+ (NSString*)stringWithInteger:(NSInteger)val;
+ (NSString*)stringWithNumber:(NSNumber*)val;
+ (NSString*)stringWithFloat:(float)val;
+ (NSString*)stringWithDouble:(double)val;
+ (NSString*)stringWithUniChar:(UniChar)val;
@end

//
//  NSString+NumberAddition.m
//  YoureMyPet
//
//  Created by 건우 최 on 12. 1. 12..
//  Copyright (c) 2012년 Unplug. All rights reserved.
//

#import "NSString+NumberAddition.h"

@implementation NSString(NumberAddition)

+ (NSString*)stringWithInt:(int)val{
    return [NSString stringWithFormat:@"%d",val];
}

+ (NSString*)stringWithInteger:(NSInteger)val{
    return [NSString stringWithFormat:@"%d",val];
}

+ (NSString*)stringWithNumber:(NSNumber*)val{
    return [NSString stringWithFormat:@"%@",val];
}
+ (NSString*)stringWithFloat:(float)val{
    return [NSString stringWithFormat:@"%f",val];
}

+ (NSString*)stringWithDouble:(double)val{
    return [NSString stringWithFormat:@"%f",val];
}

+ (NSString*)stringWithUniChar:(UniChar)val{
    return [NSString stringWithFormat:@"%c",val];
}

@end
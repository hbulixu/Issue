//
//  ITConverter.h
//  Issue
//
//  Created by 최건우 on 13. 6. 1..
//  Copyright (c) 2013년 임상진. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ITConverter : NSObject

+ (id)convert:(id)data;

+ (NSArray *)convertArray:(NSArray *)array;
+ (id)convertDictionary:(NSDictionary *)data;

+ (NSDate *)convertToDate:(NSDictionary *)data;
+ (id)convertToModel:(NSDictionary *)data;
+ (NSInteger)convertToInteger:(id)data default:(NSInteger)defaultValue;
+ (BOOL)convertToBOOL:(id)data default:(BOOL)defaultValue;
+ (id)convertResposne:(id)data;


@end

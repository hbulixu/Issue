//
//  ITConverter.m
//  Issue
//
//  Created by 최건우 on 13. 6. 1..
//  Copyright (c) 2013년 임상진. All rights reserved.
//

#import "ITConverter.h"

@implementation ITConverter

+ (NSArray *)convertArray:(NSArray *)array{
    return HTMap(^id(id obj) {
        return [self convert:obj];
    }, array);
}

+ (NSDate *)convertToDate:(NSDictionary *)data {
    return [NSDate dateWithTimeIntervalSince1970:[data[@"timestamp"] doubleValue]];
}

+ (id)convertToModel:(NSDictionary *)data {
    NSString *modelName = [data[@"__type__"] substringFromIndex:[@"model." length]];
    NSString *className = [NSString stringWithFormat:@"IT%@", modelName];
    return [[NSClassFromString(className) alloc] initWithDictionary:data];
}

+ (id)convertDictionary:(NSDictionary *)data{
    if ([[data allKeys] containsObject:@"__type__"]) {
        NSString *type = data[@"__type__"];
        if ([type isEqualToString:@"datetime"]) {
            return [self convertToDate:data];
        } else if ([type hasPrefix:@"model."]) {
            return [self convertToModel:data];
        }
    }
    NSMutableDictionary *converted = [NSMutableDictionary dictionary];
    for (id key in [data allKeys]) {
        converted[[self convert:key]] = [self convert:data[key]];
    }
    return [NSDictionary dictionaryWithDictionary:converted];
}

+ (id)convert:(id)data{
    if ([data isKindOfClass:[NSArray class]]) {
        [self convertArray:data];
    } else if ([data isKindOfClass:[NSDictionary class]]){
        [self convertDictionary:data];
    } else if ([data isKindOfClass:[NSNull class]]){
        return nil;
    }
    return data;
}

+ (NSInteger)convertToInteger:(id)data default:(NSInteger)defaultValue{
    if ([data respondsToSelector:@selector(integerValue)]) {
        return [data integerValue];
    }
    return defaultValue;
}

+ (BOOL)convertToBOOL:(id)data default:(BOOL)defaultValue{
    if ([data respondsToSelector:@selector(boolValue)]) {
        return [data boolValue];
    }
    return defaultValue;
}

+ (id)convertResposne:(id)data{
    if ([data isKindOfClass:[NSDictionary class]]) {
        return [self convert:data[@"data"]];
    }
    return data;
}

@end

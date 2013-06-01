//
//  HTConfig.m
//  iDC
//
//  Created by 건우 최 on 11. 12. 31..
//  Copyright (c) 2011년 Unplug. All rights reserved.
//

#if __has_feature(objc_arc)
#ifndef _ARC_
#define _ARC_
#endif
#endif

#import "HTConfig.h"
@interface HTConfig(Private)
@property (nonatomic, strong) NSDictionary* configData;
@end
@implementation HTConfig(Private)

static HTConfig* instance = nil;
static NSString* _path = nil;

- (NSDictionary *)configData{
    return configData;
}

- (void)setConfigData:(NSDictionary *)_configData{
    self->configData = _configData;
}

@end

@implementation HTConfig
#pragma mark - Initializers

- (id)init{
    self = [super init];
    if (self){
        NSDictionary* _configData = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"config" ofType:@"plist"]];
#ifndef _ARC_
        [configData autorelease];
#endif
        self.configData = _configData;
    }
    return self;
}

#pragma mark - Class methods
#pragma mark  Singleton

+ (HTConfig*)sharedInstance{
    @synchronized(self){
        if (instance == nil){
            instance = [[[self class] alloc] init];
        }
    }
    return instance;
}

+ (void)setConfigFilePath:(NSString*)path{
#ifndef _ARC_
    [_path release];
    [path retain];
#endif
    _path = path;
}

#pragma mark - Instance methods

- (NSString*)stringForKey:(NSString*)key{
    return [self.configData objectForKey:key];
}
- (BOOL)boolForKey:(NSString*)key{
    return [self integerForKey:key] == 0 ? NO : YES;
}
- (NSInteger)integerForKey:(NSString*)key{
    return [[self.configData objectForKey:key] integerValue];
}
- (double)doubleForKey:(NSString*)key{
    return [[self.configData objectForKey:key] doubleValue];
}
- (NSArray*)arrayForKey:(NSString*)key{
    id result = [self.configData objectForKey:key];
    if (![result isKindOfClass:[NSArray class]]){
        result = [NSArray arrayWithObject:result];
    }
    return result;
}


#ifndef _ARC_
- (void)dealloc{
    [configData release];
    [super dealloc];
}
#endif
@end

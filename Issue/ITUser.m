//
//  ITUser.m
//  Issue
//
//  Created by 최건우 on 13. 6. 1..
//  Copyright (c) 2013년 임상진. All rights reserved.
//

#import "ITUser.h"
#import "ITConverter.h"

@implementation ITUser

- (id)initWithDictionary:(NSDictionary *)dict{
    self = [super initWithDictionary:dict];
    if (self) {
        self.id = [ITConverter convertToInteger:dict[@"id"] default:0];
        self.username = [ITConverter convert:dict[@"username"]];
    }
    return self;
}

@end

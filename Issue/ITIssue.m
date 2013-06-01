//
//  ITIssue.m
//  Issue
//
//  Created by 최건우 on 13. 6. 2..
//  Copyright (c) 2013년 임상진. All rights reserved.
//

#import "ITIssue.h"
#import "ITConverter.h"

@implementation ITIssue

- (id)initWithDictionary:(NSDictionary *)dict{
    self = [super initWithDictionary:dict];
    if (self) {
        self.id = [ITConverter convertToInteger:dict[@"id"] default:0];
        self.title = [ITConverter convert:dict[@"title"]];
        self.description = [ITConverter convert:dict[@"description"]];
        self.startDate = [ITConverter convert:dict[@"start_date"]];
        self.endDate = [ITConverter convert:dict[@"end_date"]];
        self.createdAt = [ITConverter convert:dict[@"created_at"]];
    }
    return self;
}

@end

//
//  ITComment.m
//  Issue
//
//  Created by 최건우 on 13. 6. 2..
//  Copyright (c) 2013년 임상진. All rights reserved.
//

#import "ITComment.h"
#import "ITConverter.h"

@implementation ITComment

- (id)initWithDictionary:(NSDictionary *)dict {
    self = [super initWithDictionary:dict];
    if (self) {
        self.id = [ITConverter convertToInteger:dict[@"id"] default:0];
        self.writer = [ITConverter convert:dict[@"writer"]];
        self.writerID = [ITConverter convertToInteger:dict[@"writer_id"] default:0];
        self.content = [ITConverter convert:dict[@"content"]];
        self.photoID = [ITConverter convertToInteger:dict[@"photo_id"] default:0];
        self.createdAt = [ITConverter convert:dict[@"created_at"]];
    }
    return self;
}

@end

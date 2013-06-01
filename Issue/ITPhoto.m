//
//  ITPhoto.m
//  Issue
//
//  Created by 최건우 on 13. 6. 2..
//  Copyright (c) 2013년 임상진. All rights reserved.
//

#import "ITPhoto.h"
#import "ITConverter.h"

@implementation ITPhoto

- (id)initWithDictionary:(NSDictionary *)dict {
    self = [super initWithDictionary:dict];
    if (self) {
        self.id = [ITConverter convertToInteger:dict[@"id"] default:0];
        self.writer = [ITConverter convert:dict[@"writer"]];
        self.writerID = [ITConverter convertToInteger:dict[@"writer_id"] default:0];
        self.issueID = [ITConverter convertToInteger:dict[@"issue_id"] default:0];
        self.content = [ITConverter convert:dict[@"content"]];
        NSString *imageURLString = [ITConverter convert:dict[@"image_url"]];
        self.imageURL = imageURLString==nil?nil:[NSURL URLWithString:imageURLString];
        self.createdAt = [ITConverter convert:dict[@"created_at"]];
        self.commentsCount = [ITConverter convertToInteger:dict[@"comments_count"] default:0];
        self.likesCount = [ITConverter convertToInteger:dict[@"likes_count"] default:0];
    }
    return self;
}

@end

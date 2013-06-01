//
//  ITFile.m
//  Issue
//
//  Created by 최건우 on 13. 6. 1..
//  Copyright (c) 2013년 임상진. All rights reserved.
//

#import "ITFile.h"

@implementation ITFile

- (id)initWithData:(NSData *)data name:(NSString *)name mimeType:(NSString *)mimeType {
    self = [super init];
    if (self) {
        self.data = data;
        self.name = name;
        self.mimeType = mimeType;
    }
    return self;
}

+ (ITFile *)fileWithData:(NSData *)data name:(NSString *)name mimeType:(NSString *)mimeType {
    return [[[self class] alloc] initWithData:data name:name mimeType:mimeType];
}

@end

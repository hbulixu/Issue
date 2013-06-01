//
//  ITFile.h
//  Issue
//
//  Created by 최건우 on 13. 6. 1..
//  Copyright (c) 2013년 임상진. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ITFile : NSObject

@property (nonatomic, strong) NSData *data;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString* mimeType;

- (id)initWithData:(NSData *)data name:(NSString *)name mimeType:(NSString *)mimeType;
+ (ITFile *)fileWithData:(NSData *)data name:(NSString *)name mimeType:(NSString *)mimeType;

@end

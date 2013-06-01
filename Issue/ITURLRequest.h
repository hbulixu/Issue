//
//  ITURLRequest.h
//  Issue
//
//  Created by 최건우 on 13. 6. 1..
//  Copyright (c) 2013년 임상진. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ITURLRequest : NSMutableURLRequest

- (void)setForm:(NSDictionary *)form files:(NSDictionary *)files;

@end

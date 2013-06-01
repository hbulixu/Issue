//
//  ITUtil.h
//  Issue
//
//  Created by 임상진 on 13. 6. 1..
//  Copyright (c) 2013년 임상진. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"

@interface ITUtil : NSObject

+ (AFHTTPClient*)getHttpClient;
+ (void)clearCookie;
+ (void)checkLoggedIn;
+ (BOOL)loadSessionCookie;

@end

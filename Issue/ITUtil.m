//
//  ITUtil.m
//  Issue
//
//  Created by 임상진 on 13. 6. 1..
//  Copyright (c) 2013년 임상진. All rights reserved.
//

#import "ITUtil.h"

@implementation ITUtil

+ (AFHTTPClient*)getHttpClient{
    static AFHTTPClient *client = nil;
    if(client == nil){
        client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:ServerBaseUrl]];
    }
    return client;
}

+ (void)clearCookie{
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
}

+ (void)checkLoggedIn{
    
}

+ (BOOL)loadSessionCookie{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *session = [defaults objectForKey:@"session"];
    if(session){
        NSHTTPCookie *cookie=[NSHTTPCookie cookieWithProperties:
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               ServerBaseUrl, NSHTTPCookieDomain,
                               @"/",NSHTTPCookiePath,
                               @"session", NSHTTPCookieName,
                               session, NSHTTPCookieValue,
                               nil]];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
        [defaults setObject:session forKey:@"session"];
        return YES;
    }
    [defaults removeObjectForKey:@"session"];
    [ITUtil clearCookie];
    return NO;
}

@end

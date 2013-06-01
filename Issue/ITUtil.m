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

+ (void)updateSession{
    NSArray *cookies=[[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:ServerBaseUrl]];
    for(NSHTTPCookie *cookie in cookies){
        if([cookie.name isEqualToString:@"session"]){
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:cookie.value forKey:@"session"];
            [defaults synchronize];
            break;
        }
    }
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
        return YES;
    }
    [defaults removeObjectForKey:@"session"];
    [defaults synchronize];
    [ITUtil clearCookie];
    return NO;
}

@end

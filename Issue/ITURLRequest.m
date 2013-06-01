//
//  ITURLRequest.m
//  Issue
//
//  Created by 최건우 on 13. 6. 1..
//  Copyright (c) 2013년 임상진. All rights reserved.
//

#import "ITURLRequest.h"
#import "ITFile.h"
#import "NSDictionary+URLExtensions.h"

NSString *const boundary = @"xxxxxxxxxxXXxxxxxxxxxx";

@implementation ITURLRequest

- (NSData*)multipartFormDataForValue:(NSString*)value name:(NSString*)name{
    NSString* body1 = [[NSString alloc] initWithFormat:@"\r\nContent-Disposition: form-data; name=\"%@\"\r\n\r\n", name];
    NSString* body2 = [[NSString alloc] initWithFormat:@"%@",value];
    NSString* body3 = [[NSString alloc] initWithFormat:@"\r\n--%@", boundary];
    return [[[body1 stringByAppendingString:body2] stringByAppendingString:body3] dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSData*)multipartFormDataForFile:(ITFile*)file name:(NSString*)name{
    NSMutableData* data = [NSMutableData data];
    NSString*	body1 = [[NSString alloc] initWithFormat:@"\r\nContent-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", name, file.name];
    NSString*	body2 = [[NSString alloc] initWithFormat:@"Content-Type: %@\r\n\r\n",file.mimeType];
    NSData*		body3 = file.data;
    NSString*	body4 = [[NSString alloc] initWithFormat:@"\r\n\r\n--%@", boundary];
    
    [data appendData:[body1 dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[body2 dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:body3];
    [data appendData:[body4 dataUsingEncoding:NSUTF8StringEncoding]];
    return data;
}

- (void)putMultipartFormDataWithForm:(NSDictionary *)form files:(NSDictionary *)files{
    [self setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary] forHTTPHeaderField:@"Content-Type"];
    NSMutableData* body = [[NSMutableData alloc] init];
    NSString* formBodyHead = [[NSString alloc] initWithFormat:@"--%@", boundary];
    [body appendData:[formBodyHead dataUsingEncoding:NSUTF8StringEncoding]];
    
    for (NSString* name in form.allKeys) {
        [body appendData:[self multipartFormDataForValue:form[name] name:name]];
    }
    for (NSString* name in files.allKeys) {
        [body appendData:[self multipartFormDataForFile:files[name] name:name]];
    }
    
    [body appendData:[@"--\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [self setHTTPBody:body];
    // Set Length
    NSString* contentLength = [[NSString alloc] initWithFormat:@"%d",[body length]];
    [self setValue:contentLength forHTTPHeaderField:@"Content-Length"];
}

- (void)putURLEncodedDataWithForm:(NSDictionary*)form{
    [self setValue:@"application/x-www-form-urlencoded charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSString* parameters = [form urlEncodeWithEncoding:NSUTF8StringEncoding];
    NSData* data = [NSData dataWithBytes:[parameters UTF8String] length:[parameters length]];
    [self setHTTPBody:data];
}

#pragma mark - Public methods

- (void)setForm:(NSDictionary *)form files:(NSDictionary *)files{
    if ([files count] > 0) {
        [self putMultipartFormDataWithForm:form files:files];
    } else {
        [self putURLEncodedDataWithForm:form];
    }
}

@end

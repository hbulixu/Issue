//
//  ITRequest.h
//  Issue
//
//  Created by 최건우 on 13. 6. 1..
//  Copyright (c) 2013년 임상진. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTAsyncOperation.h"
#import "ITFile.h"
#import "AFJSONRequestOperation.h"

@interface ITRequest : HTAsyncOperation

@property (nonatomic, strong) NSURL *URL;
@property (nonatomic, strong) NSString *method;
@property (nonatomic, strong) NSDictionary *getArgs;
@property (nonatomic, strong) NSDictionary *form;
@property (nonatomic, strong) NSDictionary *files;

@property (nonatomic, strong) void(^successBlock)(NSHTTPURLResponse* response, id result);
@property (nonatomic, strong) void(^failureBlock)(NSHTTPURLResponse* response, NSError* error);

- (id)initWithURL:(NSURL *)URL method:(NSString*)method;
- (id)initWithURL:(NSURL *)URL method:(NSString*)method form:(NSDictionary *)form files:(NSDictionary *)files;

@property (nonatomic, strong) AFJSONRequestOperation *operation;- (id)initWithURLString:(NSString *)URLString method:(NSString*)method getArgs:(NSDictionary *)getArgs form:(NSDictionary *)form files:(NSDictionary *)files;

- (void)setSuccessBlock:(void (^)(NSHTTPURLResponse *, id))successBlock failureBlock:(void (^)(NSHTTPURLResponse *, NSError *))failureBlock;

+ (ITRequest *)requestWithURL:(NSURL *)URL method:(NSString*)method;
+ (ITRequest *)requestWithURL:(NSURL *)URL method:(NSString*)method form:(NSDictionary *)form files:(NSDictionary *)files;
+ (ITRequest *)requestWithURLString:(NSString *)URLString method:(NSString*)method getArgs:(NSDictionary *)getArgs;
+ (ITRequest *)requestWithURLString:(NSString *)URLString method:(NSString*)method getArgs:(NSDictionary *)getArgs form:(NSDictionary *)form files:(NSDictionary *)files;

@end

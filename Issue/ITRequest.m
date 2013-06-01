//
//  ITRequest.m
//  Issue
//
//  Created by 최건우 on 13. 6. 1..
//  Copyright (c) 2013년 임상진. All rights reserved.
//

#import "ITRequest.h"
#import "NSDictionary+URLExtensions.h"
#import "ITURLRequest.h"
#import "ITConverter.h"
#import "NSDataAdditions.h"

@interface ITRequest ()

@end

@implementation ITRequest

static NSString *const HostURLString = @"http://ec2-54-248-49-157.ap-northeast-1.compute.amazonaws.com:8080";

#pragma mark - Private methods

- (void)sendRequest {
    ITURLRequest *request = [[ITURLRequest alloc] initWithURL:self.URL];
    if ([self.form count] > 0 || [self.files count] > 0){
        [request setForm:self.form files:self.files];
    }
    [request setHTTPMethod:self.method];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSString *username = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
    NSString *password = [[NSUserDefaults standardUserDefaults] stringForKey:@"password"];
    if (username && password) {
        NSString *auth = [[[NSString stringWithFormat:@"%@:%@",[username lowercaseString], password] dataUsingEncoding:NSUTF8StringEncoding] base64Encoding];
        [request setValue:[NSString stringWithFormat:@"Basic %@",auth] forHTTPHeaderField:@"Authorization"];
    }
    
    AFJSONRequestOperation *operation = [[AFJSONRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.executing = NO;
        self.finished = YES;
        self.successBlock(operation.response, [ITConverter convertResposne:responseObject]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.executing = NO;
        self.finished = YES;
        self.failureBlock(operation.response, error);
    }];
    [operation start];
    self.operation = operation;
}

#pragma mark - Class methods

+ (void)requestThreadEntryPoint:(id)object{
    do {
        @autoreleasepool {
            [[NSRunLoop currentRunLoop] run];
        }
    } while (YES);
}

+ (NSThread*)requestThread{
    static NSThread *thread;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        thread = [[NSThread alloc] initWithTarget:self selector:@selector(requestThreadEntryPoint:) object:nil];
        [thread setName:@"Request Thread"];
        [thread start];
    });
    return thread;
}

+ (ITRequest *)requestWithURL:(NSURL *)URL method:(NSString*)method{
    return [[[self class] alloc] initWithURL:URL method:method];
}

+ (ITRequest *)requestWithURL:(NSURL *)URL method:(NSString*)method form:(NSDictionary *)form files:(NSDictionary *)files{
    return [[[self class] alloc] initWithURL:URL method:method form:form files:files];
}

+ (ITRequest *)requestWithURLString:(NSString *)URLString method:(NSString*)method getArgs:(NSDictionary *)getArgs{
    return [[[self class] alloc] initWithURLString:URLString method:method getArgs:getArgs];
}

+ (ITRequest *)requestWithURLString:(NSString *)URLString method:(NSString*)method getArgs:(NSDictionary *)getArgs form:(NSDictionary *)form files:(NSDictionary *)files{
    return [[[self class] alloc] initWithURLString:URLString method:method getArgs:getArgs form:form files:files];
}

#pragma mark - Initializers

- (id)initWithURL:(NSURL *)URL method:(NSString*)method{
    return [self initWithURL:URL method:method form:@{} files:@{}];
}

- (id)initWithURL:(NSURL *)URL method:(NSString*)method form:(NSDictionary *)form files:(NSDictionary *)files{
    self = [super init];
    if (self) {
        self.URL = URL;
        self.method = method;
        self.form = form;
        self.files = files;
    }
    return self;
}

- (id)initWithURLString:(NSString *)URLString method:(NSString*)method getArgs:(NSDictionary *)getArgs{
    return [self initWithURLString:URLString method:method getArgs:getArgs form:@{} files:@{}];
}

- (id)initWithURLString:(NSString *)URLString method:(NSString*)method getArgs:(NSDictionary *)getArgs form:(NSDictionary *)form files:(NSDictionary *)files{
    NSURL *baseURL = [NSURL URLWithString:HostURLString];
    NSMutableString *path = [NSMutableString stringWithString:URLString];
    if ([getArgs count] > 0) {
        [path appendString:@"?"];
        [path appendString:[getArgs urlEncodeWithEncoding:NSUTF8StringEncoding]];
    }
    NSURL *URL = [NSURL URLWithString:path relativeToURL:baseURL];
    return [self initWithURL:URL method:method form:form files:files];
}

#pragma mark - Public methods

#pragma mark - Getters and Setters
- (void)setSuccessBlock:(void (^)(NSHTTPURLResponse *, id))successBlock failureBlock:(void (^)(NSHTTPURLResponse *, NSError *))failureBlock{
    self.successBlock = successBlock;
    self.failureBlock = failureBlock;
}

#pragma mark - Overrides

#pragma mark NSOperation overrides

- (void)start{
    self.executing = YES;
    self.finished = NO;
    
    static SEL selector;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        selector = @selector(sendRequest);
    });
    [self performSelector:@selector(sendRequest) onThread:[[self class] requestThread] withObject:nil waitUntilDone:NO];
}

- (void)cancel{
    [super cancel];
    [self.operation cancel];
}

@end

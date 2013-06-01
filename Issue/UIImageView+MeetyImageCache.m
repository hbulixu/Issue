//
//  UIImageView+MeetyImageCache.m
//  meety_ios
//
//  Created by 최건우 on 13. 1. 25..
//  Copyright (c) 2013년 Meety. All rights reserved.
//

#import "UIImageView+MeetyImageCache.h"
#import <dispatch/dispatch.h>

@implementation UIImageView (MeetyImageCache)

#pragma mark - Class methods

+ (void)imageCacheThreadEntryPoint:(id)object{
    do {
        @autoreleasepool {
            [[NSRunLoop currentRunLoop] run];
        }
    } while (YES);
}

+ (NSThread*)imageCacheThread{
    static NSThread *thread;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        thread = [[NSThread alloc] initWithTarget:self selector:@selector(imageCacheThreadEntryPoint:) object:nil];
        [thread setName:@"Meety Image Cache Thread"];
        [thread start];
    });
    return thread;
}

#pragma mark - Private methods

- (void) performSetImageWithRequest:(NSURLRequest *)request key:(NSString*)key placeholder:(UIImage *)placeholderImage cache:(MeetyImageCache*)cache completionBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, UIImage *image))completion failureBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, NSError* error))failure{
    UIImage* image = [cache cachedImageForKey:key];
    if (image != nil) {
        [self setImage:image];
        if (completion) {
            completion(nil, nil, image);
        }
        return;
    }
    if (placeholderImage != nil) {
        [self setImage:placeholderImage];
    }
    __weak UIImageView *safeSelf = self;
    [cache loadImageWithRequest:request key:key completionBlock:^(NSURLRequest *request, NSURLResponse *response, UIImage *image) {
        if (image != nil) {
            [safeSelf setImage:image];
            [safeSelf setNeedsLayout];
            [safeSelf setNeedsDisplay];
        }
        if (completion) {
            completion(request, response, image);
        }
    } failureBlock:^(NSURLRequest *request, NSURLResponse *response, NSError *error) {
        if (failure) {
            failure(request, response, error);
        }
    }];
}

#pragma mark - Public methods

- (void) setImageWithURL:(NSURL *)url{
    [self setImageWithURL:url placeholder:nil];
}
- (void) setImageWithURL:(NSURL *)url placeholder:(UIImage *)placeholderImage{
    [self setImageWithURL:url placeholder:placeholderImage completionBlock:nil];
}
- (void) setImageWithURL:(NSURL *)url placeholder:(UIImage *)placeholderImage completionBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, UIImage *image))completion{
    [self setImageWithURL:url placeholder:placeholderImage completionBlock:completion failureBlock:nil];
}
- (void) setImageWithURL:(NSURL *)url placeholder:(UIImage *)placeholderImage completionBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, UIImage *image))completion failureBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, NSError* error))failure{
    [self setImageWithURL:url placeholder:placeholderImage cache:[MeetyImageCache sharedCache] completionBlock:completion failureBlock:failure];
}

- (void) setImageWithURL:(NSURL *)url placeholder:(UIImage *)placeholderImage cache:(MeetyImageCache*)cache completionBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, UIImage *image))completion failureBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, NSError* error))failure{
    [self setImageWithURL:url key:[cache keyForURL:url] placeholder:placeholderImage cache:cache completionBlock:completion failureBlock:failure];
}

- (void) setImageWithURL:(NSURL *)url key:(NSString*)key{
    [self setImageWithURL:url key:key placeholder:nil];
}
- (void) setImageWithURL:(NSURL *)url key:(NSString*)key placeholder:(UIImage *)placeholderImage{
    [self setImageWithURL:url key:key placeholder:placeholderImage completionBlock:nil];
}
- (void) setImageWithURL:(NSURL *)url key:(NSString*)key placeholder:(UIImage *)placeholderImage completionBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, UIImage *image))completion{
    [self setImageWithURL:url key:key placeholder:placeholderImage completionBlock:completion failureBlock:nil];
}
- (void) setImageWithURL:(NSURL *)url key:(NSString*)key placeholder:(UIImage *)placeholderImage completionBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, UIImage *image))completion failureBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, NSError* error))failure{
    [self setImageWithURL:url key:key placeholder:placeholderImage cache:[MeetyImageCache sharedCache] completionBlock:completion failureBlock:failure];
}
- (void) setImageWithURL:(NSURL *)url key:(NSString*)key placeholder:(UIImage *)placeholderImage cache:(MeetyImageCache*)cache completionBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, UIImage *image))completion failureBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, NSError* error))failure{
    [self setImageWithRequest:[cache requestForURL:url] key:key placeholder:placeholderImage cache:cache completionBlock:completion failureBlock:failure];
}

- (void) setImageWithRequest:(NSURLRequest *)request{
    [self setImageWithRequest:request placeholder:nil];
}
- (void) setImageWithRequest:(NSURLRequest *)request placeholder:(UIImage *)placeholderImage{
    [self setImageWithRequest:request placeholder:placeholderImage completionBlock:nil];
}
- (void) setImageWithRequest:(NSURLRequest *)request placeholder:(UIImage *)placeholderImage completionBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, UIImage *image))completion{
    [self setImageWithRequest:request placeholder:placeholderImage completionBlock:completion failureBlock:nil];
}
- (void) setImageWithRequest:(NSURLRequest *)request placeholder:(UIImage *)placeholderImage completionBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, UIImage *image))completion failureBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, NSError* error))failure{
    [self setImageWithRequest:request placeholder:placeholderImage cache:[MeetyImageCache sharedCache] completionBlock:completion failureBlock:failure];
}

- (void) setImageWithRequest:(NSURLRequest *)request placeholder:(UIImage *)placeholderImage cache:(MeetyImageCache*)cache completionBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, UIImage *image))completion failureBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, NSError* error))failure{
    [self setImageWithRequest:request key:[cache keyForURL:request.URL] placeholder:placeholderImage cache:cache completionBlock:completion failureBlock:failure];
}

- (void) setImageWithRequest:(NSURLRequest *)request key:(NSString*)key{
    [self setImageWithRequest:request key:key placeholder:nil];
}
- (void) setImageWithRequest:(NSURLRequest *)request key:(NSString*)key placeholder:(UIImage *)placeholderImage{
    [self setImageWithRequest:request key:key placeholder:placeholderImage completionBlock:nil];
}
- (void) setImageWithRequest:(NSURLRequest *)request key:(NSString*)key placeholder:(UIImage *)placeholderImage completionBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, UIImage *image))completion{
    [self setImageWithRequest:request key:key placeholder:placeholderImage completionBlock:completion failureBlock:nil];
}
- (void) setImageWithRequest:(NSURLRequest *)request key:(NSString*)key placeholder:(UIImage *)placeholderImage completionBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, UIImage *image))completion failureBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, NSError* error))failure{
    [self setImageWithRequest:request key:key placeholder:placeholderImage cache:[MeetyImageCache sharedCache] completionBlock:completion failureBlock:failure];
}
- (void) setImageWithRequest:(NSURLRequest *)request key:(NSString*)key placeholder:(UIImage *)placeholderImage cache:(MeetyImageCache*)cache completionBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, UIImage *image))completion failureBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, NSError* error))failure{
    // Search memory cache
    UIImage *image = [cache objectForKey:key];
    if (image != nil) {
        self.image = image;
        if (completion) {
            completion(request, nil, image);
        }
        return;
    }
    
    static SEL selector;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        selector = @selector(performSetImageWithRequest:key:placeholder:cache:completionBlock:failureBlock:);
    });
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[[self class] instanceMethodSignatureForSelector:selector]];
    completion = [completion copy];
    failure = [failure copy];
    [invocation setTarget:self];
    [invocation setSelector:selector];
    [invocation setArgument:&request atIndex:2];
    [invocation setArgument:&key atIndex:3];
    [invocation setArgument:&placeholderImage atIndex:4];
    [invocation setArgument:&cache atIndex:5];
    [invocation setArgument:&completion atIndex:6];
    [invocation setArgument:&failure atIndex:7];
    [invocation retainArguments];
    [invocation performSelector:@selector(invoke) onThread:[[self class] imageCacheThread] withObject:nil waitUntilDone:NO];
}
@end

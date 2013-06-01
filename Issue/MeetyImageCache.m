//
//  MeetyImageCache.m
//  meety_ios
//
//  Created by 최건우 on 13. 1. 24..
//  Copyright (c) 2013년 Meety. All rights reserved.
//

#import "MeetyImageCache.h"

@implementation MeetyImageCache

#pragma mark - Class methods
#import <dispatch/dispatch.h>

static MeetyImageCache* instance = nil;

+ (MeetyImageCache*) sharedCache{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

#pragma mark - Private methods

- (NSString*)pathForKey:(NSString*)key{
    NSString* filename = [NSString stringWithFormat:@"image-%u", [key hash]];
    return [self.cacheDirectoryPath stringByAppendingPathComponent:filename];
}

- (void)loadImageAsynchronouslyFromRequest:(NSURLRequest*)request key:(NSString *)key completionBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, UIImage *image))completion failureBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, NSError* error))failure{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURLResponse* response = nil;
        NSError* error = nil;
        UIImage* image = [self imageForRequest:request key:key response:&response error:&error];
        if (error) {
            if (failure != nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    failure(request, response, error);
                });
            }
        } else{
            if (completion != nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(request, response, image);
                });
            }
        }
    });
}

#pragma mark - Initializers

- (id)init{
    self = [super init];
    if (self) {
        self.cacheDirectoryPath = [[NSTemporaryDirectory() stringByAppendingPathComponent:@"meetycache"] stringByAppendingPathComponent:@"images"];
    }
    return self;
}

#pragma mark - Public methods

- (void) loadImageWithRequest:(NSURLRequest*)request key:(NSString *)key completionBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, UIImage *image))completion failureBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, NSError* error))failure{
    [self loadImageAsynchronouslyFromRequest:request key:key completionBlock:completion failureBlock:failure];
}
- (void) loadImageWithRequest:(NSURLRequest*)request key:(NSString *)key completionBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, UIImage *image))completion{
    [self loadImageWithRequest:request key:key completionBlock:completion failureBlock:nil];
}
- (void) loadImageWithRequest:(NSURLRequest*)request completionBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, UIImage *image))completion{
    [self loadImageWithRequest:request completionBlock:completion failureBlock:nil];
}

- (void) loadImageWithRequest:(NSURLRequest*)request completionBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, UIImage *image))completion failureBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, NSError* error))failure{
    [self loadImageWithRequest:request key:[self keyForURL:request.URL] completionBlock:completion failureBlock:failure];
}

- (void) loadImageFromURL:(NSURL *)url key:(NSString *)key completionBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, UIImage *image))completion failureBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, NSError* error))failure{
    
    [self loadImageWithRequest:[self requestForURL:url] key:key completionBlock:completion failureBlock:failure];
}
- (void) loadImageFromURL:(NSURL *)url key:(NSString *)key completionBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, UIImage *image))completion{
    
    [self loadImageFromURL:url key:key completionBlock:completion failureBlock:nil];
}
- (void) loadImageFromURL:(NSURL *)url completionBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, UIImage *image))completion{
    [self loadImageFromURL:url completionBlock:completion failureBlock:nil];
}

- (void) loadImageFromURL:(NSURL *)url completionBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, UIImage *image))completion  failureBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, NSError* error))failure{
    [self loadImageFromURL:url key:[self keyForURL:url] completionBlock:completion failureBlock:failure];
}

- (UIImage *) imageForRequest:(NSURLRequest*)request key:(NSString*)key response:(NSURLResponse *__autoreleasing *)response error:(NSError *__autoreleasing *)error{
    UIImage* image = [self cachedImageForKey:key];
    if (image != nil) {
        return image;
    }
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:response error:error];
    if (data) {
        NSURLResponse* res = *response;
        if ([res isKindOfClass:[NSHTTPURLResponse class]]) {
            NSHTTPURLResponse* httpres = (NSHTTPURLResponse*)res;
            NSDictionary* headers = [httpres allHeaderFields];
            NSMutableDictionary* dict = [NSMutableDictionary dictionary];
            for (NSString* key in headers.allKeys) {
                dict[[key lowercaseString]] = headers[key];
            }
            headers = [NSDictionary dictionaryWithDictionary:dict];
            
            if ([headers.allKeys containsObject:@"transfer-encoding"]
                && [[headers[@"transfer-encoding"] lowercaseString] isEqualToString:@"chunked"]){
                image = [UIImage imageWithData:data];
            } else{
                if([headers.allKeys containsObject:@"content-length"]){
                    NSString* contentLengthString = headers[@"content-length"];
                    NSUInteger contentLength = [contentLengthString integerValue];
                    if (data.length != contentLength) {
                        NSLog(@"Content-Length value is not same with data\'s size\n"
                              "Given : %u\n"
                              "Data\'s length : %u", contentLength, data.length);
                        if (error) {
                            *error = [NSError errorWithDomain:@"Meety"
                                                         code:200
                                                     userInfo:(@{
                                                               NSLocalizedFailureReasonErrorKey:NSLocalizedString(@"Invalid image data", @"Invalid image data")
                                                               })];
                        }
                    }else{
                        image = [UIImage imageWithData:data];
                    }
                } else{
                    image = [UIImage imageWithData:data];
                }
            }
        } else {
            image = [UIImage imageWithData:data];
        }
    }
    if (image != nil) {
        [self setImage:image forKey:key];
    }
    return image;
}
- (UIImage *) imageForRequest:(NSURLRequest*)request response:(NSURLResponse *__autoreleasing *)response error:(NSError *__autoreleasing *)error{
    return [self imageForRequest:request key:[self keyForURL:request.URL] response:response error:error];
}

- (UIImage *) imageForRequest:(NSURLRequest*)request key:(NSString*)key{
    return [self imageForRequest:request key:key response:nil error:nil];
}
- (UIImage *) imageForRequest:(NSURLRequest*)request{
    return [self imageForRequest:request key:[self keyForURL:request.URL]];
}

- (UIImage *) imageForURL:(NSURL *)url key:(NSString*)key{
    return [self imageForRequest:[self requestForURL:url] key:key];
}

- (UIImage *) imageForURL:(NSURL *)url{
    return [self imageForURL:url key:[self keyForURL:url]];
}

- (NSString*)keyForURL:(NSURL*)url{
    return [url absoluteString];
}

- (NSURLRequest*)requestForURL:(NSURL*)url{
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLCacheStorageNotAllowed timeoutInterval:60];
    return request;
}

- (UIImage *) cachedImageForKey:(NSString *)key{
    UIImage* image = [self objectForKey:key];
    if (image == nil) {
        image = [self imageFromDiskForKey:key];
        if (image != nil) {
            [self setObject:image forKey:key];
        }
    }
    return image;
}

- (UIImage *) cachedImageForURL:(NSURL *)url{
    return [self cachedImageForKey:[self keyForURL:url]];
}

- (UIImage *) imageFromDiskForKey:(NSString *)key{
    NSError* error = nil;
    NSString* path = [self pathForKey:key];
    NSData* data = [NSData dataWithContentsOfFile:path options:0 error:&error];
    if (error!=nil||data==nil) {
        return nil;
    }
    return [UIImage imageWithData:data];
}

- (UIImage *) imageFromDiskForURL:(NSURL *)url{
    return [self imageFromDiskForKey:[self keyForURL:url]];
}

- (void) setImage:(UIImage *)image forKey:(NSString *)key{
    [self setObject:image forKey:key];
    NSError* error = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:self.cacheDirectoryPath
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:&error];
    if (error) {
        NSLog(@"%@", error);
    }
    [self writeData:UIImageJPEGRepresentation(image, 1.0) toPath:[self pathForKey:key]];
}

- (void) setImage:(UIImage *)image forURL:(NSURL *)url{
    [self setImage:image forKey:[self keyForURL:url]];
}

- (void) removeImageForKey:(NSString *)key{
    [self removeObjectForKey:key];
    NSString* path = [self pathForKey:key];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
}

- (void) removeImageForURL:(NSURL *)url{
    [self removeImageForKey:[self keyForURL:url]];
}

- (void) removeAllCachedImages{
    [self removeAllObjects];
    [[NSFileManager defaultManager] removeItemAtPath:self.cacheDirectoryPath error:nil];
}

- (void) writeData:(NSData *)data toPath:(NSString *)path{
    NSError* error = nil;
    [path pathComponents];
    [data writeToFile:path options:0 error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
}

@end

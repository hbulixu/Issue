//
//  MeetyImageCache.h
//  meety_ios
//
//  Created by 최건우 on 13. 1. 24..
//  Copyright (c) 2013년 Meety. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface MeetyImageCache : NSCache

+ (MeetyImageCache*) sharedCache;

@property (nonatomic, strong) NSString* cacheDirectoryPath;

- (void) loadImageWithRequest:(NSURLRequest*)request key:(NSString *)key completionBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, UIImage *image))completion failureBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, NSError* error))failure;
- (void) loadImageWithRequest:(NSURLRequest*)request key:(NSString *)key completionBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, UIImage *image))completion;
- (void) loadImageWithRequest:(NSURLRequest*)request completionBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, UIImage *image))completion;
- (void) loadImageWithRequest:(NSURLRequest*)request completionBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, UIImage *image))completion failureBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, NSError* error))failure;

- (void) loadImageFromURL:(NSURL *)url key:(NSString *)key completionBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, UIImage *image))completion failureBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, NSError* error))failure;
- (void) loadImageFromURL:(NSURL *)url key:(NSString *)key completionBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, UIImage *image))completion;
- (void) loadImageFromURL:(NSURL *)url completionBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, UIImage *image))completion;
- (void) loadImageFromURL:(NSURL *)url completionBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, UIImage *image))completion failureBlock:(void (^)(NSURLRequest* request, NSURLResponse* response, NSError* error))failure;

- (UIImage *) imageForRequest:(NSURLRequest*)request key:(NSString*)key response:(NSURLResponse *__autoreleasing *)response error:(NSError *__autoreleasing *)error;
- (UIImage *) imageForRequest:(NSURLRequest*)request response:(NSURLResponse *__autoreleasing *)response error:(NSError *__autoreleasing *)error;

- (UIImage *) imageForRequest:(NSURLRequest*)request key:(NSString*)key;
- (UIImage *) imageForRequest:(NSURLRequest*)request;

- (UIImage *) imageForURL:(NSURL *)url key:(NSString*)key;
- (UIImage *) imageForURL:(NSURL *)url;

- (UIImage *) cachedImageForKey:(NSString *)key;
- (UIImage *) cachedImageForURL:(NSURL *)url;

- (UIImage *) imageFromDiskForKey:(NSString *)key;
- (UIImage *) imageFromDiskForURL:(NSURL *)url;

- (NSString*)keyForURL:(NSURL*)url;
- (NSURLRequest*)requestForURL:(NSURL*)url;

- (void) setImage:(UIImage *)image forKey:(NSString *)key;
- (void) setImage:(UIImage *)image forURL:(NSURL *)url;
- (void) removeImageForKey:(NSString *)key;
- (void) removeImageForURL:(NSURL *)url;
- (void) removeAllCachedImages;

- (void) writeData:(NSData *)data toPath:(NSString *)path;

@end
